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
