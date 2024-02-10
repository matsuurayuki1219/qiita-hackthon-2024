//
//  API.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

enum QiitaAPI {

    static func getArticles(page: Int, perPage: Int, query: String) async throws -> [QiitaArticleEntity] {
        var request = URLRequest(url: EndPoint.articles(page: page, perPage: perPage, query: query).url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode([QiitaArticleEntity].self, from: data)
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }
}
