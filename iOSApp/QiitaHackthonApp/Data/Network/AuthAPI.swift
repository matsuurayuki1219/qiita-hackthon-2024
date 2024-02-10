//
//  AuthAPI.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

enum AuthAPI {

    static func login(id: String) async throws -> AuthEntity {
        let url = URL(string: "XXX")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var json = [String: Any]()
        // json["email"] = "email"
        // json["password"] = "password"
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
    
}
