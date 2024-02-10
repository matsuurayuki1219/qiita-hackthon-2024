import UIKit

class StackTableViewCell: UITableViewCell {
    var stack = Stack(.horizontal)

    // override point
    func configure(_ stack: Stack) {}

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        configure(stack)
        stack.views.forEach { view in
            contentView.insertSubview(view, at: 0)
        }
    }

    // MARK: - UIView Override

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return stack.calculatedSize(size)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stack.layout(in: bounds)
    }
}
