//
//  StampEntity.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation

struct StampEntity: Codable {
    let count: Int
    let stamp: String

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case stamp = "stamp"
    }
}
