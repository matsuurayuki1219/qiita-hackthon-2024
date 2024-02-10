//
//  LoginViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation
import UIKit
import Combine

class LoginViewController: UIViewController {

    let viewModel = LoginViewModel()

    private var cancellables: Set<AnyCancellable> = []

    private lazy var userNameTextField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .default
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        padding.backgroundColor = UIColor.clear
        view.leftView = padding
        view.leftViewMode = .always
        view.rightView = padding
        view.rightViewMode = .always
        return view
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var indicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .green40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(userNameTextField)
        view.addSubview(loginButton)
        view.addSubview(indicatorView)
        setConstraint()
        addObserver()
    }

    func setConstraint() {
        userNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 56.0).isActive = true

        loginButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 64).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 56.0).isActive = true

        indicatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        indicatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func addObserver() {
        viewModel.$isLoading
            .sink(receiveValue: { isLoading in
                if isLoading {
                    self.indicatorView.startAnimating()
                } else {
                    self.indicatorView.stopAnimating()
                }
            }).store(in: &cancellables)
    }

    @objc func loginButtonTapped() {
        guard let userName = userNameTextField.text else { return }
        viewModel.login(userName: userName)
    }

}
