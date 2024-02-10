//
//  MemberEntity.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

struct MemberEntity: Codable {
    let id: Int
    let name: String
    let profileImageUri: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case profileImageUri = "image_url"
        case status = "status"
    }
}
