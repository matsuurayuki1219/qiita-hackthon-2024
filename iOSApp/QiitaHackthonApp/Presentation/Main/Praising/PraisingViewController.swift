//
//  PraisingViewController.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import UIKit

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
        view.layer.cornerRadius = 15
        view.textColor = UIColor("#C8C8C8")
        view.font = .systemFont(ofSize: 16)
        view.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("バトンをつなぐ", for: .normal)
        button.setTitleColor(UIColor("#292929"), for: .normal)
        button.backgroundColor = UIColor("#F8BD32")
        button.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 30.0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var member: MemberModel? {
        didSet {
            guard let member = member else { return }
            profileImageView.nameLabel.text = member.name
            profileImageView.profileImageView.loadURL(URL(string: member.profileImageUri)!)

            profileImageView.isHidden = false
            selectNiceGuyButton.isHidden = true
            profileImageView.setNeedsLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#292929")
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(selectNiceGuyButton)
        view.addSubview(profileImageView)
        view.addSubview(textField)
        view.addSubview(uploadButton)
        addConstraint()
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

private extension PraisingViewController {
    
    func addConstraint() {
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
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
        
        uploadButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        uploadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        uploadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 57.0).isActive = true
        
    }
    
}


