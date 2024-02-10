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

class ExtraPraisingViewModel: ObservableObject {
    let authRepository = AuthRepository()
    let userRepository = UserRepository()
    let praiseRepository = PraiseRepository()

    // user
    @Published var praisedUser: MemberModel?
    @Published var praisingUser: MemberModel?
    @Published var myUser: MemberModel?

    // stamp
    @Published var stamps = [Stamp(reactionStamp: .clap, count: 3), Stamp(reactionStamp: .heart, count: 1),]

    // message
    @Published var praisingUserMessage: MessageModel?
    @Published var extraUserMessages: [MessageModel] = []
    
    func prepare() {
        Task {
            do {
                let me = try await authRepository.getMe()
                let members = try await userRepository.getMembers()
                let praiseModel = try await praiseRepository.getCurrentPraise()

                //                myName = me?.name ?? "Bug"
                //                myImageName = me?.profileImageUri ?? "Bug"
                //                userName = praiseModel?.toUserId

//                stamps = praiseModel?.stamps.compactMap { Stamp(reactionStamp: ReactionStamp(rawValue: $0.stamp) ?? .clap, count: $0.count) } ?? []
            } catch {

            }
        }

    }
    func postComment() {
        // call post comment api
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
