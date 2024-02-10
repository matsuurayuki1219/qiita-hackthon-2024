//
//  UserRepository.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

class UserRepository {

    func getMembers() async throws -> [MemberModel] {
        return try await UserAPI.getMembers().map { $0.toModel() }
    }

}
