//
//  PraisedViewModel.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import Foundation

struct Stamp: Hashable {
    var imageName: String
    var count: Int
}

class PraisedViewModel: ObservableObject {
    @Published var comments = ["asjefklfaslk"]
    @Published var stamps = [Stamp(imageName: "✅", count: 3), Stamp(imageName: "😄", count: 1),]
    @Published var userImageName = "cat"
    @Published var userName = "Yuki"

    @Published var leadComment = "jjfioasjesjfoaesfjejiaeojsjojsfoajsosofjsefofjsoefjas"
    @Published var leadCommentUserName = "Hikaru"
    @Published var leadCommentUserImageName = "cat"

    func postComment(comment: String) {
        

    }

    func postStamp(stamp: String) {

    }
}
