//
//  StampView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import SwiftUI

struct StampView: View {
    var didTap: ((ReactionStamp) -> Void)? = nil
    @Binding var reactionStamp: ReactionStamp
    @Binding var number: Int

    var body: some View {
        Button(action: {
            didTap?(reactionStamp)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray100)
                Image(reactionStamp.rawValue)
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
}
