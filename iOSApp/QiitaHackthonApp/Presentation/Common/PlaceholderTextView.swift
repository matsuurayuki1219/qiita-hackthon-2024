//
//  PlaceholderTextView.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation
import UIKit

class PlaceholderTextView: UITextView {

    var placeholder = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textColor = UIColor("#C8C8C8")
        return label
    }()

    func setText(_ text: String) {
        self.text = text
        changeVisibility()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        placeholderLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -48).isActive = true

        self.delegate = self
    }

    private func changeVisibility() {
        if self.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        changeVisibility()
    }
}
