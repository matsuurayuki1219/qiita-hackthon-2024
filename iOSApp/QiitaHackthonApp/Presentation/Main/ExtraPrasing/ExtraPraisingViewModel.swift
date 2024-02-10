//
//  ExtraPraisingViewModel.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import Foundation

class ExtraPraisingViewModel: ObservableObject {
    @Published var comments = ["asjefklfaslk"]
    @Published var stamps = [Stamp(reactionStamp: .clap, count: 3), Stamp(reactionStamp: .heart, count: 1),]

    @Published var userImageName = "cat"
    @Published var userName = "Yuki"

    @Published var leadComment = "jjfioasjesjfoaesfjejiaeojsjojsfoajsosofjsefofjsoefjas"
    @Published var leadCommentUserName = "Hikaru"
    @Published var leadCommentUserImageName = "cat"

    @Published var myImageName = "cat"
    @Published var myName = "Yuki"


    func postComment() {

    }

    func postStamp() {

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
