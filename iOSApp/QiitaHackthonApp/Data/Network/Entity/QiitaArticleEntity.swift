//
//  QiitaArticleEntity.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

struct QiitaArticleEntity: Codable {
    let id: String
    let title: String
    let url: String
    let likesCount: Int
    let user: UserEntity
    let tags: [TagEntity]
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case url = "url"
        case likesCount = "likes_count"
        case user = "user"
        case tags = "tags"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
