//
//  CommentView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import SwiftUI

struct CommentView: View {
    var comment: String
    var userName: String
    var userImageName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray100)
            VStack {
                Text(comment)
                    .foregroundStyle(Color.grayText)
                HStack {
                    Spacer()
                    Image(userImageName)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Text(userName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white107)
                }
            }
            .padding(20)
        }
    }
}
