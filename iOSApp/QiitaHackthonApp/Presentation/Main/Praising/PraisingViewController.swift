//
//  PraisingViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import UIKit
import Combine

class PraisingViewController: UIViewController {

    let viewModel = PraisingViewModel()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "My Turn"
        view.font = .systemFont(ofSize: 25)
        view.textColor = UIColor("#FFFFFF")
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "他人のいいところを\nシェアするターンです"
        view.font = .systemFont(ofSize: 25, weight: .bold)
        view.textColor = UIColor("#F8BD32")
        view.textAlignment = .center
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var selectNiceGuyButton: UIButton = {
        let button = UIButton()
        button.setTitle("素敵人を選ぶ", for: .normal)
        button.setTitleColor(UIColor("#FFFFFF"), for: .normal)
        button.addTarget(self, action: #selector(selectNiceGuysButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor("#FFFFFF").cgColor
        return button
    }()

    private lazy var profileImageView: ProfileImageView = {
        let view = ProfileImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectNiceGuysButtonTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var textField: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor("#333333")
        view.textColor = UIColor("#C8C8C8")
        view.font = .systemFont(ofSize: 16)
        view.layer.cornerRadius = 15
        view.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var placeholderLabel: UILabel = {
        let view = UILabel()
        view.text = "相手の素敵な行動・言動をみんなに共有して素敵連鎖をリレーのバトンでつなげてください"
        view.textColor = UIColor("#C8C8C8")
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("バトンをつなぐ", for: .normal)
        button.setTitleColor(UIColor("#292929"), for: .normal)
        button.backgroundColor = UIColor("#CCCCCC")
        button.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 30.0
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var indicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var member: MemberModel? {
        didSet {
            guard let member = member else { return }
            profileImageView.nameLabel.text = member.name
            profileImageView.profileImageView.loadURL(URL(string: member.profileImageUri)!)

            profileImageView.isHidden = false
            selectNiceGuyButton.isHidden = true
            profileImageView.setNeedsLayout()

            validateContent()
        }
    }

    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#292929")
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(selectNiceGuyButton)
        view.addSubview(profileImageView)
        view.addSubview(textField)
        view.addSubview(placeholderLabel)
        view.addSubview(uploadButton)
        view.addSubview(indicatorView)
        addConstraint()
        addObserver()
        registerKeyboardEvent()

        profileImageView.isHidden = true
        selectNiceGuyButton.isHidden = false
    }

    @objc func selectNiceGuysButtonTapped() {
        let vc = MemberListViewController()
        vc.onSelectedGuys = { member in
            self.member = member
        }
        present(vc, animated: true)
    }

    @objc func uploadButtonTapped() {
        guard let text = textField.text else { return }
        guard let member = member else { return }
        viewModel.upload(toUserId: member.id, text: text)
    }

    func registerKeyboardEvent() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboardTouchOutside)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }

}

extension PraisingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        placeholderLabel.isHidden = count != 0
        view.setNeedsLayout()
        validateContent()
    }
}

private extension PraisingViewController {

    func addConstraint() {

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        selectNiceGuyButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40).isActive = true
        selectNiceGuyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        selectNiceGuyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        selectNiceGuyButton.heightAnchor.constraint(equalToConstant: 72.0).isActive = true

        profileImageView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 72.0).isActive = true

        textField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 150).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 210.0).isActive = true

        placeholderLabel.topAnchor.constraint(equalTo: textField.topAnchor, constant: 20).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 24).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -24).isActive = true

        uploadButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        uploadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        uploadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 57.0).isActive = true

        indicatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        indicatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }

    func addObserver() {
        viewModel.subject.sink { [weak self] action in
            switch action {
            case .success:
                print("Success!!")
            case .failure:
                print("Failure!!")
            }
        }.store(in: &subscriptions)

        viewModel.$isLoading
            .sink(receiveValue: { isLoading in
                if isLoading {
                    self.indicatorView.startAnimating()
                } else {
                    self.indicatorView.stopAnimating()
                }
            }).store(in: &subscriptions)
    }

    func validateContent() {
        let isValid = member != nil && textField.text.count > 0
        uploadButton.isEnabled = isValid
        if isValid {
            uploadButton.backgroundColor = UIColor("#F8BD32")
        } else {
            uploadButton.backgroundColor = UIColor("#CCCCCC")
        }
    }

}


