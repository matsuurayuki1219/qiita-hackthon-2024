//
//  PraiseEntity.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation

struct PraiseEntity: Codable {
    let id: Int
    let title: String
    let toUserId: Int
    let fromUserId: Int
    let comments: [CommentEntity]
    let stamps: [StampEntity]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case toUserId = "to_user_id"
        case fromUserId = "from_user_id"
        case comments = "comments"
        case stamps = "stamps"
    }
}
