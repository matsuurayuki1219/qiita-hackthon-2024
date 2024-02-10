//
//  PraiseAPI.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/11.
//

import Foundation

enum PraiseAPI {
    
    static func postPraise(toUserId: Int, title: String = "", description: String) async throws -> PraiseEntity {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/praise")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var json = [String: Any]()
        json["to_user_id"] = toUserId
        json["title"] = title
        json["description"] = description
        let jsonObject = try JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonObject
        request.addValue("Bearer \(String(describing: UserDefaults.accessToken!))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode(PraiseEntity.self, from: data)
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }

    static func getCurrentPraise() async throws -> PraiseEntity {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/praise/current_praise")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(String(describing: UserDefaults.accessToken!))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                return try JSONDecoder().decode(PraiseEntity.self, from: data)
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }

    static func putComment(praiseId: Int, comment: String) async throws {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/praise/\(praiseId)/comment")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        var json = [String: Any]()
        json["comment"] = comment
        let jsonObject = try JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonObject
        request.addValue("Bearer \(String(describing: UserDefaults.accessToken!))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                // no-ops
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }

    static func putStamp(praiseId: Int, stamp: String) async throws {
        let url = URL(string: "https://vocal-circle-387923.an.r.appspot.com/praise/\(praiseId)/stamp")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        var json = [String: Any]()
        json["stamp"] = stamp
        let jsonObject = try JSONSerialization.data(withJSONObject: json, options: [])
        request.httpBody = jsonObject
        request.addValue("Bearer \(String(describing: UserDefaults.accessToken!))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else { throw ApiError.unknown }
        if httpStatus.statusCode == 200 {
            do {
                // no-ops
            } catch {
                throw ApiError.decodingError(error)
            }
        } else {
            throw ApiError.unknown
        }
    }


}
