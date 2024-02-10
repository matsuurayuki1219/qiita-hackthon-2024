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
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.grayText)
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: userImageName)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
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
