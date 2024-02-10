//
//  QiitaRepository.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

class QiitaRepository {

    func getArticles(page: Int,perPage: Int, query: String) async throws -> [QiitaArticleModel] {
        return try await QiitaAPI.getArticles(page: page, perPage: perPage, query: query).map { $0.toModel() }
    }
    
}
