//
//  UIView+CustomAnimation.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import UIKit

extension UIView {
    static func softSpringAnimation(delay: TimeInterval = 0, _ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.6,
                       delay: delay,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.6,
                       options: [.allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }

    static func smoothAnimation(delay: TimeInterval = 0, _ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: delay,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.66,
                       options: [.allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }

    static func simpleAnimation(delay: TimeInterval = 0, _ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3,
                       delay: delay,
                       options: [.allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }

    static func cellPushAnimation(_ animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.allowUserInteraction],
                       animations: animations,
                       completion: completion)
    }
}

