//
//  MainViewModel.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation
import Combine

@MainActor
class MainViewModel {

    enum Action {
        case waiting
        case submitter
        case praised
        case others
    }

    @Published var isLoading = false

    let subject = PassthroughSubject<Action, Never>()

    let repository = AuthRepository()

    func prepare() {
        Task {
            do {
                isLoading = true
                let data = try await repository.getMe()
                print("status: \(data.status)")
                switch data.status {
                case .waiting:
                    subject.send(.waiting)
                case .praised:
                    subject.send(.praised)
                case .submitter:
                    subject.send(.submitter)
                case .others:
                    subject.send(.others)
                default:()
                }
                isLoading = false
            } catch {
                isLoading = false
            }
        }
    }

}
