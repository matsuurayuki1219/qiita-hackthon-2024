import UIKit

class Stack {
    var direction: Direction
    var position = CGPoint(x: 0.5, y: 0.5)
    var spacer = Spacer.fixed(8)
    var insets = UIEdgeInsets.zero

    var items = [Item]()

    private(set) var targetRect = CGRect()
    private(set) var actualRect = CGRect()

    init(_ direction: Direction) {
        self.direction = direction
    }
}

// MARK: - Interface

extension Stack {
    var frame: CGRect {
        return views.map { $0.frame }.lassoRect().inset(by: insets.inverted())
    }
    var views: [UIView] {
        let topLevel = items.compactMap { $0.stackable as? UIView }
        let nested = items.compactMap { ($0.stackable as? Stack)?.views }.flatMap { $0 }
        return topLevel + nested
    }
    var stacks: [Stack] {
        let topLevel = items.compactMap { $0.stackable as? Stack }
        let nested = topLevel.flatMap { $0.stacks }
        return topLevel + nested
    }

    func layout(in rect: CGRect) {
        let calc = FrameCalculator(stack: self, rect: rect.inset(by: insets))
        calc.calculate()
        calc.apply()

        targetRect = rect
        actualRect = calc.lassoRect
    }
}

// MARK: - Types (Public)

extension Stack {
    enum Direction {
        case horizontal, vertical
    }
    enum Spacer {
        case fixed(CGFloat)
        case fill(minimum: CGFloat)
    }
    enum Length: Equatable {
        case fit
        case fill
        case fixed(CGFloat)
        case ratio(CGFloat)
        case aspectRatio(CGFloat)
    }

    struct Item {
        var stackable: Stackable
        var width: Length
        var height: Length
        var spacer: Spacer?
        var padding: CGSize?
    }
}

extension Stackable {
    func stackItem(
        width: Stack.Length = .fit,
        height: Stack.Length = .fit,
        spacer: Stack.Spacer? = nil,
        padding: CGSize? = nil
    ) -> Stack.Item {
        .init(stackable: self, width: width, height: height, spacer: spacer, padding: padding)
    }
}

// MARK: - Types (Private)

private extension Stack {
    class Estimate {
        var item: Item
        var space = CGFloat()
        var frame = CGRect()

        init(_ item: Item) {
            self.item = item
        }
    }

    class FrameCalculator {
        let stack: Stack
        let rect: CGRect
        let estimates: [Estimate]

        init(stack: Stack, rect: CGRect) {
            self.stack = stack
            self.rect = rect
            self.estimates = stack.items.map { Estimate($0) }
        }

        func calculate() {
            calcLeastSpaces()
            calcSizes()
            calcActualSpaces()
            calcFrames()
        }

        func apply() {
            estimates.forEach { e in
                e.item.stackable.apply(frame: e.frame)
            }
        }
    }
}

// MARK: - Calculator Logic (Private)

private extension Stack {
    var hasFill: Bool {
        let targets = items.filter { $0.isVisible }
        let visibleFills = targets.filter { item in
            if let innerStack = item.stackable as? Stack {
                if innerStack.direction == direction {
                    return innerStack.hasFill
                }
            }
            else if item.stackable !== targets.last?.stackable {
                return ((item.spacer ?? spacer)?.isFill ?? false)
            }
            return false
        }
        return !visibleFills.isEmpty
    }
}

private extension Stack.FrameCalculator {
    var visibleEstimates: [Stack.Estimate] {
        return estimates.filter { $0.item.isVisible }
    }
    var totalLength: CGFloat {
        switch stack.direction {
        case .horizontal:
            return visibleEstimates.map { $0.frame.width + $0.space }.reduce(0, +)

        case .vertical:
            return visibleEstimates.map { $0.frame.height + $0.space }.reduce(0, +)
        }
    }
    var lassoRect: CGRect {
        return visibleEstimates.map { $0.frame }.lassoRect()
    }

    func calcLeastSpaces() {
        visibleEstimates.exceptLast.forEach { e in
            e.space = (e.item.spacer ?? stack.spacer).least
        }
    }

    func calcSizes() {
        var total = estimates.map { $0.space }.reduce(0, +)

        // calc sizes (fixable > flexible)
        switch stack.direction {
        case .horizontal:
            estimates.filter { $0.item.width != .fill }.forEach { e in
                let fitSize = CGSize(width: rect.width - total, height: rect.height)
                e.frame.size = e.item.size(fitSize: fitSize, stackSize: rect.size)
                total += (e.item.isVisible ? e.frame.width : 0)
            }
            let count = visibleEstimates.filter { $0.item.width == .fill }.count
            estimates.filter { $0.item.width == .fill }.forEach { e in
                let width = (rect.width - total) / CGFloat(0 < count ? count : 1)
                let fitSize = CGSize(width: width, height: rect.height)
                e.frame.size = e.item.size(fitSize: fitSize, stackSize: rect.size)
            }
        case .vertical:
            estimates.filter { $0.item.height != .fill }.forEach { e in
                let fitSize = CGSize(width: rect.width, height: rect.height - total)
                e.frame.size = e.item.size(fitSize: fitSize, stackSize: rect.size)
                total += (e.item.isVisible ? e.frame.height : 0)
            }
            let count = visibleEstimates.filter { $0.item.height == .fill }.count
            estimates.filter { $0.item.height == .fill }.forEach { e in
                let height = (rect.height - total) / CGFloat(0 < count ? count : 1)
                let fitSize = CGSize(width: rect.width, height: height)
                e.frame.size = e.item.size(fitSize: fitSize, stackSize: rect.size)
            }
        }
    }

    func calcActualSpaces() {
        let isHorizontal = (stack.direction == .horizontal)
        let targets = visibleEstimates
        let leastSpaces = targets.exceptLast.map { $0.space }.reduce(0, +)
        let totalSize = targets.map { isHorizontal ? $0.frame.width : $0.frame.height }.reduce(0, +)

        let fillCount = targets.exceptLast.filter { ($0.item.spacer ?? stack.spacer).isFill }.count
        let fillable = (isHorizontal ? rect.width : rect.height) - (totalSize + leastSpaces)
        let fill = (0 < fillCount ? fillable / CGFloat(fillCount) : 0)

        targets.forEach { e in
            if case .fill(let minimum) = e.item.spacer ?? stack.spacer {
                e.space = minimum + fill
            }
        }
    }

    func calcFrames() {
        switch stack.direction {
        case .horizontal:
            let totalWidth = (stack.hasFill ? rect.width : totalLength)
            let remainWidth = rect.width - totalWidth
            var nextX = rect.minX + remainWidth * stack.position.x
            var backstage = nextX

            estimates.forEach { e in
                e.frame.origin.x = (e.item.isVisible ? nextX : backstage)
                e.frame.origin.y = rect.minY + (rect.height - e.frame.height) * stack.position.y
                if e.item.isVisible {
                    nextX = e.frame.maxX + e.space
                    backstage = e.frame.maxX
                }
            }
        case .vertical:
            let totalHeight = (stack.hasFill ? rect.height : totalLength)
            let remainHeight = rect.height - totalHeight
            var nextY = rect.minY + remainHeight * stack.position.y
            var backstage = nextY

            estimates.forEach { e in
                e.frame.origin.x = rect.minX + (rect.width - e.frame.width) * stack.position.x
                e.frame.origin.y = (e.item.isVisible ? nextY : backstage)
                if e.item.isVisible {
                    nextY = e.frame.maxY + e.space
                    backstage = e.frame.maxY
                }
            }
        }
    }
}

private extension Stack.Item {
    var isVisible: Bool {
        if let view = stackable as? UIView {
            return (0 < view.alpha && !view.isHidden)
        }
        else if let stack = stackable as? Stack {
            return !stack.items.allSatisfy { !$0.isVisible }
        }
        return true
    }

    func size(fitSize: CGSize, stackSize: CGSize) -> CGSize {
        let w: CGFloat = {
            switch width {
            case .fit:                    return stackable.calculatedSize(fitSize).width
            case .fill:                   return fitSize.width
            case .fixed(let value):       return value
            case .ratio(let ratio):       return stackSize.width * ratio
            case .aspectRatio(let ratio): return stackSize.height * ratio
            }
        }()
        let h: CGFloat = {
            switch height {
            case .fit:                    return stackable.calculatedSize(fitSize).height
            case .fill:                   return fitSize.height
            case .fixed(let value):       return value
            case .ratio(let ratio):       return stackSize.height * ratio
            case .aspectRatio(let ratio): return stackSize.width * ratio
            }
        }()
        return CGSize(width: w, height: h).padding(padding).clamped(min: .zero)
    }
}

// MARK: - Private Extension

private extension Array {
    var exceptLast: ArraySlice<Element> { 0 < count ? prefix(count - 1) : [] }
}

private extension Array where Element == CGRect {
    func lassoRect() -> CGRect {
        let minX = self.min(by: { $0.minX < $1.minX })?.minX ?? 0
        let maxX = self.max(by: { $0.maxX < $1.maxX })?.maxX ?? 0
        let minY = self.min(by: { $0.minY < $1.minY })?.minY ?? 0
        let maxY = self.max(by: { $0.maxY < $1.maxY })?.maxY ?? 0
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}

private extension Stack.Spacer {
    var least: CGFloat {
        switch self {
        case .fixed(let value):  return value
        case .fill(let minimum): return minimum
        }
    }
    var isFill: Bool {
        if case .fill = self {
            return true
        }
        return false
    }
}

private extension CGSize {
    func padding(_ pad: CGSize?) -> CGSize {
        return CGSize(width: width + (pad?.width ?? 0),
                      height: height + (pad?.height ?? 0))
    }

    func clamped(min: CGSize? = nil, max: CGSize? = nil) -> Self {
        var size = self
        size.width = size.width.clamped(min: min?.width, max: max?.width)
        size.height = size.height.clamped(min: min?.height, max: max?.height)
        return size
    }
}

private extension UIEdgeInsets {
    func inverted() -> Self {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}

// MARK: - Protocol

protocol Stackable: AnyObject {
    func apply(frame: CGRect)
    func calculatedSize(_ fitSize: CGSize) -> CGSize
}

extension UIView: Stackable {
    private static var estimateView = UIView()

    func apply(frame: CGRect) {
        if transform != .identity || !CATransform3DIsIdentity(layer.transform) {
            layout { f in
                f.size = sizeJustFit()
                f.origin.x = frame.midX - f.width / 2
                f.origin.y = frame.midY - f.height / 2
            }
        }
        else {
            layout { f in
                f = frame
            }
        }
    }

    func calculatedSize(_ fitSize: CGSize) -> CGSize {
        let fits = sizeThatFits(fitSize)
        let estimateView = Self.estimateView

        if transform != .identity {
            estimateView.transform = transform
            estimateView.bounds.size = fits
            return estimateView.frame.size
        }
        else if !CATransform3DIsIdentity(layer.transform) {
            estimateView.layer.transform = layer.transform
            estimateView.bounds.size = fits
            return estimateView.frame.size
        }
        return fits
    }
}

extension Stack: Stackable {
    func apply(frame: CGRect) {
        layout(in: frame)
    }

    func calculatedSize(_ fitSize: CGSize) -> CGSize {
        let rect = CGRect(origin: .zero, size: fitSize).inset(by: insets)
        let calc = FrameCalculator(stack: self, rect: rect)
        calc.calculate()

        return calc.lassoRect.inset(by: insets.inverted()).size
    }
}
