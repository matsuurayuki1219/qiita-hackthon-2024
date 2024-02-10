//
//  StampEntity.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation

struct StampEntity: Codable {
    let id: Int
    let fromUserId: Int
    let stamp: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fromUserId = "from_user_id"
        case stamp = "stamp"
    }
}
