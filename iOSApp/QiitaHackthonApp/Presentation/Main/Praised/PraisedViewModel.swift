//
//  PraisedViewModel.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import Foundation

struct Stamp: Hashable {
    var reactionStamp: ReactionStamp
    var count: Int
}

struct Coment: Hashable {
    var comment = "jjfioasjesjfoaesfjejiaeojsjojsfoajsosofjsefofjsoefjas"
    var userName = "Hikaru"
    var userImageName = "cat"
}

class PraisedViewModel: ObservableObject {
    let authRepository = AuthRepository()
    let userRepository = UserRepository()
    let praiseRepository = PraiseRepository()

    var praiseId: Int?

    @Published var inputMessage = ""

    // user
    @Published var praisedUser: MemberModel?  // ✅
    @Published var praisingUser: MemberModel?  // ✅
    @Published var myUser: MemberModel? // ✅

    // stamp
    @Published var stamps: [Stamp] = [] // ✅

    // message
    @Published var praisingUserMessage: MessageModel? // ✅
    @Published var extraUserMessages: [MessageModel] = []

    func prepare() {
        Task {
            do {
                let me = try await authRepository.getMe()
                let members = try await userRepository.getMembers()
                let praiseModel = try await praiseRepository.getCurrentPraise()

                praiseId = praiseModel.id
                praisedUser = members.first { $0.id == praiseModel.toUserId }
                praisingUser = members.first { $0.id == praiseModel.fromUserId }
                myUser = me

                stamps = praiseModel.stamps.compactMap { Stamp(reactionStamp: ReactionStamp(rawValue: $0.stamp) ?? .clap, count: $0.count) }

                if let praisingUser = praisingUser {
                    praisingUserMessage = MessageModel(message: praiseModel.description, user: praisingUser)
                }

                extraUserMessages = praiseModel.comments.compactMap { comment in
                    let user = members.first { $0.id == comment.fromUserId}
                    return MessageModel(message: comment.comment, user: user!)
                }
            } catch {
                print(error)
            }
        }
    }

    func navigateToPraising() {

    }
}
