//
//  PlusView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import SwiftUI

struct PlusView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray100)
                .padding(4)
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
        }
        .frame(width: 48, height: 48)
    }
}
