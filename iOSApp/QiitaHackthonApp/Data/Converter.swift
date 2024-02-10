//
//  Converter.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

extension QiitaArticleEntity {
    func toModel() -> QiitaArticleModel {
        return QiitaArticleModel(
            title: title,
            url: url,
            likesCount: likesCount,
            user: user.toModel(),
            tags: tags.map { $0.toModel() },
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

extension UserEntity {
    func toModel() -> UserModel {
        return UserModel(
            id: id,
            name: name,
            profileImageUrl: profileImageUrl
        )
    }
}

extension TagEntity {
    func toModel() -> TagModel {
        return TagModel(name: name)
    }
}

extension AuthEntity {
    func toModel() -> AuthModel {
        return AuthModel(accessToken: accessToken)
    }
}

extension MemberEntity {
    func toModel() -> MemberModel {
        return MemberModel(
            id: id,
            name: name,
            profileImageUri: profileImageUri,
            status: status.toMemberStatus()
        )
    }
}

extension String {
    func toMemberStatus() -> MemberStatus {
        switch self {
        case "waiting": .waiting
        case "submitter": .submitter
        case "praised": .praised
        case "others": .others
        default: .unknown
        }
    }
}

extension PraiseEntity {
    func toModel() -> PraiseModel {
        return PraiseModel(
            id: id,
            title: title,
            toUserId: toUserId,
            fromUserId: fromUserId,
            comments: comments.map { $0.toModel() },
            stamps: stamps.map { $0.toModel() }
        )
    }
}

extension CommentEntity {
    func toModel() -> CommentModel {
        return CommentModel(
            id: id,
            fromUserId: fromUserId,
            comment: comment
        )
    }
}


extension StampEntity {
    func toModel() -> StampModel {
        return StampModel(
            id: id,
            fromUserId: fromUserId,
            stamp: stamp
        )
    }
}
