import UIKit

extension UIView {
    enum LayoutMode {
        /// Uses rounded frame for pixel-perfect layout.
        case rounded
        /// Use the original frame when implementing parallax, etc.
        case floating
    }

    /// Call this method in `viewWillLayoutSubviews()` or `layoutSubviews()` to set frame.
    func layout(_ mode: LayoutMode = .rounded, _ modifier: (inout CGRect) -> Void) {
        var f = CGRect(origin: .zero, size: bounds.size)
        modifier(&f)

        switch mode {
        case .rounded:
            setFrameWithIdentityTransform(f.rounded)

        case .floating:
            setFrameWithIdentityTransform(f)
        }
    }

    func sizeJustFit() -> CGSize {
        return sizeThatFits(.zero)
    }
}

private extension UIView {
    /// To maintain the expected layout even when transform is applied,
    /// temporarily remove transform, set the frame, and reapply it.
    func setFrameWithIdentityTransform(_ rect: CGRect) {
        if transform != .identity {
            let lastTransform = transform

            transform = .identity
            setFrameIfNeeded(rect)

            transform = lastTransform
        }
        else if !CATransform3DIsIdentity(layer.transform) {
            let lastTransform3D = layer.transform

            layer.transform = CATransform3DIdentity
            setFrameIfNeeded(rect)

            layer.transform = lastTransform3D
        }
        else {
            setFrameIfNeeded(rect)
        }
    }

    /// This is to avoid unnecessary frame updates,
    /// and also to allow the rubber-banding of the UIScrollView to work properly.
    func setFrameIfNeeded(_ rect: CGRect) {
        if frame != rect {
            frame = rect
            setNeedsLayout()
        }
    }
}
private extension CGRect {
    /// Returns pixel-perfect frame with appropriate scaling.
    var rounded: CGRect {
        let scale = UIScreen.main.scale
        return CGRect(x: (origin.x * scale).rounded() / scale,
                      y: (origin.y * scale).rounded() / scale,
                      width: (width * scale).rounded(.up) / scale,
                      height: (height * scale).rounded(.up) / scale)
    }
}
