//
//  AuthRepository.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

class AuthRepository {

    func login(userName: String) async throws -> AuthModel {
        return try await AuthAPI.login(userName: userName).toModel()
    }

    func saveAccessToken(token: String) {
        UserDefaults.accessToken = token
    }

    func getAccessToken() -> String? {
        return UserDefaults.accessToken
    }

    func getMe() async throws -> MemberModel {
        return try await AuthAPI.me().toModel()
    }

}
