//
//  PraisedViewController.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import UIKit
import SwiftUI

class PraisedViewController: UIViewController {
    let viewModel = PraisedViewModel()

    // MARK: - UIViewController Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setBaseSwiftUI()
        viewModel.prepare()
    }

    // MARK: - Private

    private func setBaseSwiftUI() {
        var swiftUIView = PraisedView(viewModel: viewModel)
        swiftUIView.transitionDelegate = self
        let vc = UIHostingController(rootView: swiftUIView)
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension PraisedViewController: PraisedViewTransitionDelegate {
    func transition(_ praisedView: PraisedView, transition: PraisedView.TransitionAction) {
        switch transition {
        case .navigateToPraising:
            navigateToPraising()
        }
    }

    private func navigateToPraising() {
        let vc = PraisingViewController()
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
}
