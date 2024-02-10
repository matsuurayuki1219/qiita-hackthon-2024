//
//  ApiError.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/01/19.
//

import Foundation

enum ApiError: Error {
    case decodingError(Error)
    case unknown
}
