//
//  ViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import UIKit
import Then

class ViewController: UIViewController {

    lazy var goToComplimentRelayButton = UIButton().then { v in
        v.setTitle("goToComplimentRelayButton", for: .normal)
        v.addTarget(self, action: #selector(goToComplimentRelay), for: .touchUpInside)
    }

    private lazy var contentStack = Stack(.vertical).then { v in
        v.items = [
            goToComplimentRelayButton.stackItem(),
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(goToComplimentRelayButton)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        contentStack.layout(in: view.bounds)
    }


    @objc func goToComplimentRelay() {
        let vc = ComplimentRelayViewController()
        let nav = UINavigationController(rootViewController: vc).then { nav in
            nav.modalPresentationStyle = .fullScreen
        }
        present(nav, animated: true)
    }
}

