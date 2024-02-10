//
//  AuthAPI.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

enum AuthAPI {

    static func login(userName: String) async throws -> AuthEntity {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var json = [String: Any]()
        json["username"] = userName
        let jsonObject = try JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonObject
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode(AuthEntity.self, from: data)
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }

    static func me() async throws -> MemberEntity {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/auth/me")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(String(describing: UserDefaults.accessToken))", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode(MemberEntity.self, from: data)
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }
}
