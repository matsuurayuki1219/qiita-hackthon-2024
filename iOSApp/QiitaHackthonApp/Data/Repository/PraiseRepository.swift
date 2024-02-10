//
//  PraiseRepository.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

class PraiseRepository {

    func uploadPraise(toUserId: Int, title: String = "", description: String) async throws -> PraiseModel {
        return try await PraiseAPI.postPraise(toUserId: toUserId, description: description).toModel()
    }

    func getCurrentPraise() async throws -> PraiseModel {
        return try await PraiseAPI.getCurrentPraise().toModel()
    }

    func putPraise(praiseId: Int, comment: String) async throws {
        try await PraiseAPI.putComment(praiseId: praiseId, comment: comment)
    }

    func putStamp(praiseId: Int, stamp: String) async throws {
        try await PraiseAPI.putStamp(praiseId: praiseId, stamp: stamp)
    }

}
