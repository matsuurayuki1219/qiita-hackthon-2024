//
//  LoginViewModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

@MainActor
class LoginViewModel {

    let repository = AuthRepository()

    @Published var isLoading: Bool = false

    func login(userName: String) {
        Task {
            do {
                isLoading = true
                let data = try await repository.login(userName: userName)
                let accessToken = data.accessToken
                repository.saveAccessToken(token: accessToken)
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }

}
