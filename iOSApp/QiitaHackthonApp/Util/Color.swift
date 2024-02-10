//
//  Color.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }


    static let yellow103 = Color(hex: "#F8BD32")
    static let black108 = Color(hex: "#292929")
    static let gray100 = Color(hex: "#333333")
    static let gray44444 = Color(hex: "#444444")
    static let white107 = Color(hex: "#FFFFFF")
    static let grayText = Color(hex: "#C8C8C8")
}
