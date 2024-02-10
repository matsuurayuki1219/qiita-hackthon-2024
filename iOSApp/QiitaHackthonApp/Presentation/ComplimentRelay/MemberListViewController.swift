//
//  MemberListViewController.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import UIKit

struct Member {
    var name: String
    var imageURL: URL?
}

extension Member {
    static func dummyData() -> Member {
        return Member(name: "test", imageURL: URL(string: "https://picsum.photos/200/300"))
    }
}

class MemberListViewController: UIViewController {

    var items = [Member]()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "MemberListViewController"
        view.backgroundColor = UIColor("#252525")

        view.addSubview(topTitle)
        view.addSubview(closeButton)
        view.addSubview(tableView)

        items = (0...10).map { _ in Member.dummyData() }
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
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberCell.id, for: indexPath)

        if let cell = cell as? MemberCell {
            cell.item = items[indexPath.row]
        }
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}

extension MemberListViewController {
    class MemberCell: StackTableViewCell {

        static let id = "MemberCell"

        var item: Member? {
            didSet {
                guard let item = item else { return }
                // TODO: Add Nuke
                profileImageNameView.profileImageView.loadURL(item.imageURL)
                profileImageNameView.nameLabel.text = item.name
            }
        }

        // MARK: - SubViews

        lazy var profileImageNameView = ProfileImageNameView()

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

    class ProfileImageNameView: StackView {

        // MARK: - SubViews

        lazy var profileImageView = UIImageView().then { v in
            v.backgroundColor = .gray
            v.contentMode = .scaleAspectFill
            v.layer.cornerRadius = 20
            v.layer.masksToBounds = true
        }

        lazy var nameLabel = UILabel().then { v in
            v.font = .boldSystemFont(ofSize: 20)
            v.textColor = .white
        }

        override func configure(_ stack: Stack) {
            stack.direction = .horizontal
            stack.insets = .init(top: 16, left: 24, bottom: 16, right: 24)
            stack.spacer = .fixed(16)
            stack.items = [
                profileImageView.stackItem(width: .fixed(40), height: .fixed(40)),
                nameLabel.stackItem(width: .fill)
            ]

            backgroundView = UIView().then { v in
                v.layer.borderWidth = 1
                v.layer.borderColor = UIColor.white.cgColor
                v.layer.masksToBounds = true
                v.layer.cornerCurve = .continuous
                v.layer.cornerRadius = 16
            }
        }
    }
}
