//
//  ProfileImageView.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation
import UIKit

class ProfileImageView: StackView {

    // MARK: - SubViews

    lazy var profileImageView = UIImageView().then { v in
        v.backgroundColor = .gray
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 20
        v.layer.masksToBounds = true
    }

    lazy var nameLabel = UILabel().then { v in
        v.font = .boldSystemFont(ofSize: 20)
        v.textColor = .white
    }

    override func configure(_ stack: Stack) {
        stack.direction = .horizontal
        stack.insets = .init(top: 16, left: 24, bottom: 16, right: 24)
        stack.spacer = .fixed(16)
        stack.items = [
            profileImageView.stackItem(width: .fixed(40), height: .fixed(40)),
            nameLabel.stackItem(width: .fill)
        ]

        backgroundView = UIView().then { v in
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor.white.cgColor
            v.layer.masksToBounds = true
            v.layer.cornerCurve = .continuous
            v.layer.cornerRadius = 16
        }
    }
}
