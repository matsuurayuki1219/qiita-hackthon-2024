//
//  StampView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import SwiftUI

struct StampView: View {
    @Binding var imageName: String
    @Binding var number: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray100)
            Image(imageName)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("\(number)")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .padding(5)
                        .foregroundStyle(.white)
                }
            }
        }
        .frame(width: 48, height: 48)
    }
}
