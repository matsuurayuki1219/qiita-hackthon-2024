//
//  MainViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    let viewModel = MainViewModel()

    private var subscriptions = Set<AnyCancellable>()

    private lazy var indicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(indicatorView)
        view.backgroundColor = UIColor("#292929")
        addConstraint()
        addObserver()
    }

    private func addConstraint() {
        indicatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        indicatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func addObserver() {
        viewModel.subject.sink { [weak self] action in
            switch action {
            case .waiting:
                let vc = WaitingViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            case .praised:
                let vc = PraisedViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            case .submitter:
                let vc = PraisingViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            case .others:
                let vc = ExtraPraisingViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }.store(in: &subscriptions)

        viewModel.$isLoading
            .sink(receiveValue: { [weak self] isLoading in
                if isLoading {
                    self?.indicatorView.startAnimating()
                } else {
                    self?.indicatorView.stopAnimating()
                }
            }).store(in: &subscriptions)
    }

}
