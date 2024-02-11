//
//  MemberListViewModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation
import SwiftUI

@MainActor
class MemberListViewModel {

    @Published var isLoading = false
    @Published var members: [MemberModel] = []

    let userRepository = UserRepository()
    let authRepository = AuthRepository()

    init() {
        Task {
            do {
                isLoading = true
                let response = try await userRepository.getMembers()
                let me = try await authRepository.getMe()

                members = response.filter { $0.id != me.id }

                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
}
