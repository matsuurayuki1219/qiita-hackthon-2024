import UIKit

class StackScrollView: UIScrollView {
    var stack = Stack(.horizontal)

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
        stack.views.forEach(addSubview)
    }

    // MARK: - UIView Override

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return stack.calculatedSize(size)
    }

    override func layoutSubviews() {
        stack.layout(in: .init(origin: .zero, size: bounds.size))

        if contentSize != stack.frame.size {
            contentSize = stack.frame.size
        }
    }
}
