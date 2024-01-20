//
//  QiitaArticleViewModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation
import Combine

@MainActor
class QiitaArticleViewModel {

    @Published var articles: [QiitaArticleModel] = []
    @Published var isLoading: Bool = false

    private let repository = QiitaRepository()

    init() {
        Task {
            do {
                isLoading = true
                let data = try await repository.getArticles(page: 1, perPage: 100, query: "Swift")
                print(data)
                articles = data
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }

}
