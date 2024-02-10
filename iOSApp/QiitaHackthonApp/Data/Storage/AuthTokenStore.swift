//
//  AuthTokenStore.swift
//  QiitaHackthonApp
//
//  Created by 松浦裕久 on 2024/02/10.
//

import Foundation

extension UserDefaults {
    
    static var accessToken: String? {
        get {
            UserDefaults.standard.object(forKey: "accessToken") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
}
