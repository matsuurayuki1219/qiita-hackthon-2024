//
//  EndPoint.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

enum EndPoint {

    private static let baseURL = URL(string: "https://qiita.com/api/v2")!

    case articles(page: Int, perPage: Int, query: String)

    var url: URL {
        switch self {
        case .articles(let page, let perPage, let query):
            var baseQueryURL = URLComponents(url: EndPoint.baseURL.appendingPathComponent("items"), resolvingAgainstBaseURL: false)!
            baseQueryURL.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "per_page", value: String(perPage)),
                URLQueryItem(name: "query", value: query)
            ]
            return baseQueryURL.url!
        }
    }
}
