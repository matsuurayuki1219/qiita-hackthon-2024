import UIKit

class StackControl: UIControl {
    var stack = Stack(.horizontal)

    var backgroundView: UIView? {
        didSet {
            guard oldValue !== backgroundView else {
                return
            }
            oldValue?.removeFromSuperview()

            if let backgroundView = backgroundView {
                insertSubview(backgroundView, at: 0)
            }
        }
    }

    func configure(_ stack: Stack) {}

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadStack()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadStack()
    }

    func loadStack() {
        configure(stack)
        stack.views.forEach { view in
            if let backgroundView = backgroundView {
                insertSubview(view, aboveSubview: backgroundView)
            }
            else {
                insertSubview(view, at: 0)
            }
        }
    }

    // MARK: - UIView Override

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return stack.calculatedSize(size)
    }

    override func layoutSubviews() {
        backgroundView?.layout { f in
            f = bounds
        }
        stack.layout(in: bounds)
    }
}
