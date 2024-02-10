//
//  MemberListViewController.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import UIKit
import Combine

class MemberListViewController: UIViewController {

    var onSelectedGuys: ((MemberModel) -> Void)?

    let viewModel = MemberListViewModel()

    // MARK: - Subview

    lazy var topTitle = UILabel().then { v in
        v.text = "素敵人を選ぶ"
        v.textColor = .white
        v.font = .boldSystemFont(ofSize: 20)
    }

    lazy var closeButton = UIButton().then { v in
        let image = UIImage(systemName: "xmark.circle")
        v.setImage(image, for: .normal)
        v.tintColor = .systemGray
    }

    lazy var tableView = UITableView().then { v in
        v.dataSource = self
        v.delegate = self
        v.register(MemberCell.self, forCellReuseIdentifier: MemberCell.id)

        // style
        v.separatorStyle = .none
        v.contentInset.bottom = 60
        v.estimatedRowHeight = 140
        v.backgroundColor = .clear
    }

    // MARK: - Combine

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Model

    private var members: [MemberModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#252525")
        view.addSubview(topTitle)
        view.addSubview(closeButton)
        view.addSubview(tableView)
        addObserver()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let w = view.bounds.width
        let h = view.bounds.height
        let top = view.safeAreaInsets.top

        topTitle.layout { f in
            f.origin.x = 16
            f.origin.y = top
            f.size = topTitle.sizeJustFit()
        }
        closeButton.layout { f in
            f.size.width = 30
            f.size.height = 30
            f.origin.y = top
            f.origin.x = w - f.width - 16
        }

        tableView.layout { f in
            f.origin.y = topTitle.frame.maxY + 20
            f.origin.x = 24
            f.size.width = w - 48
            f.size.height = h
        }
    }

    private func addObserver() {
        viewModel.$members
            .sink(receiveValue: { members in
                self.members = members
            }).store(in: &cancellables)

        viewModel.$isLoading
            .sink(receiveValue: { isLoading in
                if isLoading {
                    // self.indicatorView.startAnimating()
                } else {
                    // self.indicatorView.stopAnimating()
                }
            }).store(in: &cancellables)
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberCell.id, for: indexPath)

        if let cell = cell as? MemberCell {
            cell.member = members[indexPath.row]
        }
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = members[indexPath.row]
        onSelectedGuys?(member)
        dismiss(animated: true)
    }
}

extension MemberListViewController {
    class MemberCell: StackTableViewCell {

        static let id = "MemberCell"

        var member: MemberModel? {
            didSet {
                guard let member = member else { return }
                profileImageNameView.profileImageView.loadURL(URL(string: member.profileImageUri)!)
                profileImageNameView.nameLabel.text = member.name
            }
        }

        // MARK: - SubViews

        lazy var profileImageNameView = ProfileImageView()

        // MARK: - StackTableViewCell Override

        override func configure(_ stack: Stack) {
            stack.direction = .horizontal
            stack.insets = .init(top: 8, left: 0, bottom: 8, right: 0)
            stack.spacer = .fixed(16)
            stack.items = [
                profileImageNameView.stackItem()
            ]
        }

        // MARK: - UITableViewCell Override

        override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            UIView.cellPushAnimation {
                let scale = CGFloat(highlighted ? 0.98 : 1.00)
                self.transform = .init(scaleX: scale, y: scale)
            }
        }

        // MARK: - UIView Override

        override func didMoveToSuperview() {
            super.didMoveToSuperview()
            backgroundColor = .clear
            selectedBackgroundView = UIView().then { v in
                v.backgroundColor = .clear
            }
            contentView.backgroundColor = .clear
        }
    }

}
