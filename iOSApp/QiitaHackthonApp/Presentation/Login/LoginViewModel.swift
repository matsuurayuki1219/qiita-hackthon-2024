//
//  LoginViewModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation
import Combine

@MainActor
class LoginViewModel {

    enum Action {
        case success
        case failure
    }

    let repository = AuthRepository()

    @Published var isLoading: Bool = false

    let subject = PassthroughSubject<Action, Never>()

    func login(userName: String) {
        Task {
            do {
                isLoading = true
                let data = try await repository.login(userName: userName)
                let accessToken = data.accessToken
                repository.saveAccessToken(token: accessToken)
                isLoading = false
                subject.send(.success)
            } catch {
                isLoading = false
                subject.send(.failure)
            }
        }
    }

}
