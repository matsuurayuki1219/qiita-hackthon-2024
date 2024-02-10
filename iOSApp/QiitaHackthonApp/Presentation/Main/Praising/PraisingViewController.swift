//
//  PraisingViewController.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import UIKit

class PraisingViewController: UIViewController {

    // MARK: - Subview

    lazy var topTitle = UILabel().then { v in
        v.text = "My Turn"
        v.textColor = .white
        v.font = .boldSystemFont(ofSize: 25)
    }

    lazy var subtitle = UILabel().then { v in
        v.text = "他人のいいところを\nシェアするターンです"
        v.textAlignment = .center
        v.textColor = UIColor("#F8BD32")
        v.font = .boldSystemFont(ofSize: 25)
        v.numberOfLines = 2
    }

    lazy var complimentTargetButton = UIButton().then { v in
        v.setTitle("素敵人を選ぶ", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.titleLabel?.font = .boldSystemFont(ofSize: 16)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.gray40.cgColor
        v.layer.cornerRadius = 8
        v.addTarget(self, action: #selector(tappedComplimentTargetButton), for: .touchUpInside)
    }

    lazy var complimentText = UITextView().then { v in
        v.backgroundColor = UIColor("#333333")
        v.layer.cornerRadius = 15
    }

    lazy var complimentSubmitButton = UIButton().then { v in
        v.setTitle("投稿する", for: .normal)
        v.setTitleColor(.black, for: .normal)
        v.titleLabel?.font = .boldSystemFont(ofSize: 16)

        v.backgroundColor = UIColor("#CCCCCC")
        v.layer.cornerRadius = 30
        v.addTarget(self, action: #selector(tappedComplimentSubmitButton), for: .touchUpInside)
    }

    private lazy var contentStack = Stack(.vertical).then { v in
        v.spacer = .fixed(30)
        v.position.y = 0
        v.insets = .init(top: 40, left: 20, bottom: 0, right: 20)
        v.items = [
            topTitle.stackItem(),
            subtitle.stackItem(),
            complimentTargetButton.stackItem(width: .fixed(320), height: .fixed(80)),
            complimentText.stackItem(width: .fixed(320), height: .fixed(250)),
            complimentSubmitButton.stackItem(width: .fixed(260), height: .fixed(60)),
        ]
    }

    // MARK: - override ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ComplimentViewController"

        view.backgroundColor = .black

        contentStack.views.forEach(view.addSubview)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        contentStack.layout(in: view.bounds)
    }

    // MARK: - Action

    @objc func tappedComplimentTargetButton(_ sender: UIControl) {
        print(#function)
    }

    @objc func tappedComplimentSubmitButton(_ sender: UIControl) {
        print(#function)
    }
}
