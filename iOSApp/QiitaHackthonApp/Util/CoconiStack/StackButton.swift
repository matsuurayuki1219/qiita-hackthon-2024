import UIKit

class StackButton: StackControl {
    private var touchBeganFromInside = false
    private var isPressed = false {
        didSet {
            guard isPressed != oldValue else {
                return
            }
            UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction) {
                self.updateAlpha()
            }
        }
    }

    // MARK: - UIControl Override

    override var isEnabled: Bool { didSet { updateAlpha() } }

    // MARK: - UIResponder Override

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled, let t = touches.first else {
            return
        }
        isPressed = bounds.contains(t.location(in: self))
        touchBeganFromInside = isPressed
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled, let t = touches.first else {
            return
        }
        if touchBeganFromInside {
            isPressed = bounds.contains(t.location(in: self))
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else {
            return
        }
        isPressed = false
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled, let t = touches.first else {
            return
        }
        if touchBeganFromInside, bounds.contains(t.location(in: self)) {
            sendActions(for: .touchUpInside)
        }
        isPressed = false
    }

    // MARK: - Update

    private func updateAlpha() {
        alpha = (isEnabled && !isPressed ? 1.0 : 0.5)
    }
}
