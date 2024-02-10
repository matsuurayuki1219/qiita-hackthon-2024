//
//  PraiseModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation

struct PraiseModel {
    let id: Int
    let description: String
    let toUserId: Int
    let fromUserId: Int
    let comments: [CommentModel]
    let stamps: [StampModel]
}
