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

    @Published var isLoading = false

    let subject = PassthroughSubject<Void, Never>()

    let repository = PraisedRepository()

    func upload(toUserId: Int, text: String) {
        Task {
            do {
                isLoading = true
                try await repository.upload(toUserId: toUserId, description: text)
                isLoading = false
                subject.send()
            } catch {
                isLoading = false
            }
        }
    }

}
