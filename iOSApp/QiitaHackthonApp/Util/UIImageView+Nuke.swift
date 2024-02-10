//
//  UIImageView+Nuke.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import UIKit
import Nuke

extension UIImageView {
    func loadURL(_ url: URL? ) {
        let options = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.33)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
