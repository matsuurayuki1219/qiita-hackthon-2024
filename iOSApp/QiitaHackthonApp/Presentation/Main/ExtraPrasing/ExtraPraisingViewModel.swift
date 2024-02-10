//
//  ExtraPraisingViewModel.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import Foundation

class ExtraPraisingViewModel: ObservableObject {
    @Published var comments = ["asjefklfaslk"]
    @Published var stamps = [Stamp(imageName: "stamp_heart", count: 3), Stamp(imageName: "stamp_clap", count: 1),]

    @Published var userImageName = "cat"
    @Published var userName = "Yuki"

    @Published var leadComment = "jjfioasjesjfoaesfjejiaeojsjojsfoajsosofjsefofjsoefjas"
    @Published var leadCommentUserName = "Hikaru"
    @Published var leadCommentUserImageName = "cat"
//    @Published var

    func postComment(comment: String) {

    }

    func postStamp(stamp: String) {

    }
}
