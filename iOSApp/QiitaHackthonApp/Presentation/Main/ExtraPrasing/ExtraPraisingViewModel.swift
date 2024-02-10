//
//  ExtraPraisingViewModel.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import Foundation

struct MessageModel: Hashable {
    var message: String
    var user: MemberModel
}

@MainActor
class ExtraPraisingViewModel: ObservableObject {
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
    func postComment() {
        // call post comment api
        guard let praiseId = praiseId else { return }
        Task {
            do {
                try await praiseRepository.putPraise(praiseId: praiseId, comment: inputMessage)
            } catch {
                // do nothing
            }
        }
        // update extraUserMessages
    }

    func postStamp() {
        // call post stamp api
    }

    func addReactionStamp(_ stamp: ReactionStamp) {
        if let index = stamps.firstIndex(where: { $0.reactionStamp == stamp }) {
            var tempStamp = stamps[index]
            tempStamp.count += 1
            stamps[index] = tempStamp
        }
        else {
            stamps.append(.init(reactionStamp: stamp, count: 1))
        }

        postStamp()
    }
}

enum ReactionStamp: String, CaseIterable {
    case clap = "stamp_clap"
    case exciting = "stamp_exciting"
    case fire = "stamp_fire"
    case good = "stamp_good"
    case heart = "stamp_heart"
    case medal = "stamp_medal"
    case smile = "stamp_smile"
    case sparks = "stamp_sparks"
}
