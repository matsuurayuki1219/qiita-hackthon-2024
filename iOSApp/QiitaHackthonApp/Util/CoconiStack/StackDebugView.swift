import UIKit

class StackDebugView: UIView {
    static let didUpdate = Notification.Name("didUpdate")

    static var isEnabled = false {
        didSet {
            NotificationCenter.default
                .post(name: Self.didUpdate, object: self, userInfo: nil)
        }
    }

    var rootStacks = [Stack]()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .systemBackground

        NotificationCenter.default
            .addObserver(self, selector: #selector(receive), name: Self.didUpdate, object: nil)
    }

    deinit {
        NotificationCenter.default
            .removeObserver(self, name: Self.didUpdate, object: nil)
    }

    // MARK: - Notification

    @objc func receive(_ notification: Notification) {
        if notification.name == Self.didUpdate {
            setNeedsDisplay()
        }
    }

    // MARK: - UIView Override

    override func draw(_ rect: CGRect) {
        guard Self.isEnabled, let c = UIGraphicsGetCurrentContext() else {
            return
        }
        c.setLineCap(.round)
        c.setLineWidth(1)

        let stacks = rootStacks.map { [$0] + $0.stacks }.flatMap { $0 }
        let count = stacks.count
        let colors = (0..<count).map { i -> UIColor in
            let hue = CGFloat(i) / CGFloat(count)
            return .init(hue: hue, saturation: 1, brightness: 0.8, alpha: 1)
        }
        zip(stacks, colors).forEach { stack, color in
            // draw target rect with solid line
            c.setStrokeColor(color.withAlphaComponent(0.2).cgColor)
            c.setLineDash(phase: 0, lengths: [])
            c.stroke(stack.targetRect)

            // draw actual rect with dashed line
            c.setStrokeColor(color.cgColor)
            c.setLineDash(phase: 0, lengths: [2])
            c.stroke(stack.actualRect)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
}
