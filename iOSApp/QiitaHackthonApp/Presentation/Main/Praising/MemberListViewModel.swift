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

    let repository = UserRepository()

    init() {
        Task {
            do {
                isLoading = true
                let response = try await repository.getMembers()
                members = response
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }
}
