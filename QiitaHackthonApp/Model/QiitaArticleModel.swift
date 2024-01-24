//
//  QiitaArticleModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

struct QiitaArticleModel {
    let title: String
    let url: String
    let likesCount: Int
    let user: UserModel
    let tags: [TagModel]
    let createdAt: String
    let updatedAt: String
}
