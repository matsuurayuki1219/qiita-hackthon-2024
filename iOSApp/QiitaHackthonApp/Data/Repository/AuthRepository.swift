//
//  AuthRepository.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

class AuthRepository {

    func login(id: String) async throws -> AuthModel {
        return try await AuthAPI.login(id: id).toModel()
    }

    func saveAccessToken(token: String) {
        UserDefaults.accessToken = token
    }

    func getAccessToken() -> String? {
        return UserDefaults.accessToken
    }

}
