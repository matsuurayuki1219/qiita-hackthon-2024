//
//  ViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import UIKit
import Then

class ViewController: UIViewController {

    lazy var goToPraisingButton = UIButton().then { v in
        v.setTitle("goToPraisingButton", for: .normal)
        v.addTarget(self, action: #selector(goToPraising), for: .touchUpInside)
    }

    lazy var goToPraisedButton = UIButton().then { v in
        v.setTitle("goToPraisedButton", for: .normal)
        v.addTarget(self, action: #selector(goToPraised), for: .touchUpInside)
    }

    lazy var goToMemberListViewButton = UIButton().then { v in
        v.setTitle("goToMemberListViewButton", for: .normal)
        v.addTarget(self, action: #selector(goToMemberListView), for: .touchUpInside)
    }

    private lazy var contentStack = Stack(.vertical).then { v in
        v.items = [
            goToPraisingButton.stackItem(),
            goToPraisedButton.stackItem(),
            goToMemberListViewButton.stackItem(),
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        contentStack.views.forEach(view.addSubview)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        contentStack.layout(in: view.bounds)
    }


    @objc func goToPraising() {
        let vc = PraisingViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

    @objc func goToPraised() {
        let vc = PraisedViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    @objc func goToMemberListView() {
        let vc = MemberListViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

