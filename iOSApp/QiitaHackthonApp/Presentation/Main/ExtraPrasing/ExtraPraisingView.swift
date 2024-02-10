//
//  ExtraPraisingView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import SwiftUI

struct ExtraPraisingView: View {
    @ObservedObject var viewModel: ExtraPraisingViewModel

    var attributedUserName: AttributedString {
        var result = AttributedString("\(viewModel.userName)")
        result.font = .title2
        result.foregroundColor = .yellow103
        return result
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("\(attributedUserName)さんの行動が\n素敵バトンをつなぎました")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Image("good_baton")

                VStack(spacing: -15) {
                    Image(viewModel.userImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Image("solo_body")
                }

                Text("Yukiさんの素敵さをHikaruさんが\nみんなにシェアしました")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Spacer()
                Group {
                    LeadCommentView(
                        stamps: $viewModel.stamps,
                        comment: $viewModel.leadComment,
                        userName: $viewModel.leadCommentUserName,
                        userImageName: $viewModel.leadCommentUserImageName
                    )
                    ForEach($viewModel.comments, id: \.self) { comment in
                        CommentView(
                            comment: $viewModel.leadComment,
                            userName: $viewModel.leadCommentUserName,
                            userImageName: $viewModel.leadCommentUserImageName
                        )
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }
        }
        .padding(20)
        .background(Color.black108)

    }
}


#Preview {
    ExtraPraisingView(viewModel: ExtraPraisingViewModel())
}
