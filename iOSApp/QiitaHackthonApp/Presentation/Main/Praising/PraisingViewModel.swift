//
//  PraisingViewModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation
import Combine

@MainActor
class PraisingViewModel {

    enum Action {
        case success
        case failure
    }

    @Published var isLoading = false

    let subject = PassthroughSubject<Action, Never>()

    let repository = PraiseRepository()

    func upload(toUserId: Int, text: String) {
        Task {
            do {
                isLoading = true
                try await repository.uploadPraise(toUserId: toUserId, description: text)
                isLoading = false
                subject.send(.success)
            } catch {
                isLoading = false
                subject.send(.failure)
            }
        }
    }

}
