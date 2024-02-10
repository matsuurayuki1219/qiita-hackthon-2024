//
//  UserAPI.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

enum UserAPI {

    static func getMembers() async throws -> [MemberEntity] {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode([MemberEntity].self, from: data)
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }

}
