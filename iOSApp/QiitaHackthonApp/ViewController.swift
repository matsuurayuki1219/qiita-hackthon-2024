//
//  ViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import UIKit
import Then

class ViewController: UIViewController {

    lazy var goToComplimentButton = UIButton().then { v in
        v.setTitle("goToComplimentButton", for: .normal)
        v.addTarget(self, action: #selector(goToCompliment), for: .touchUpInside)
    }

    lazy var goToComplimentSharedButton = UIButton().then { v in
        v.setTitle("goToComplimentSharedButton", for: .normal)
        v.addTarget(self, action: #selector(goToComplimentShared), for: .touchUpInside)
    }

    private lazy var contentStack = Stack(.vertical).then { v in
        v.items = [
            goToComplimentButton.stackItem(),
            goToComplimentSharedButton.stackItem(),
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


    @objc func goToCompliment() {
        let vc = ComplimentViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    @objc func goToComplimentShared() {
        let vc = ComplimentSharedViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

