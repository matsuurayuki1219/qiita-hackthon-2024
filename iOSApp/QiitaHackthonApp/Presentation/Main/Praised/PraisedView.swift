//
//  PraisedView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import SwiftUI

struct PraisedView: View {
    @ObservedObject var viewModel: PraisedViewModel

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

                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.yellow103)
                    VStack {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))]) {
                            ForEach($viewModel.stamps, id: \.self) { stamp in
                                StampView(reactionStamp: stamp.reactionStamp, number: stamp.count)
                            }
                        }
                        .offset(y: -40)

                        Group {
                            Text(viewModel.leadComment)
                                .foregroundStyle(Color.gray100)
                            HStack {
                                Spacer()
                                Image(viewModel.userImageName)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                Text(viewModel.userName)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.gray100)
                            }
                        }
                        .offset(y: -20)
                    }
                    .padding(20)
                }

                ForEach($viewModel.comments, id: \.self) { comment in
//                    CommentView(
//                        comment: viewModel.leadComment,
//                        userName:$viewModel.leadCommentUserName,
//                        userImageName: viewModel.leadCommentUserImageName
//                    )
                }

                Spacer()
                Button(action: {
                    print("tap buton")
                }) {
                    Text("次のバトンへつなぐ").fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color.black108)
                        .background(.yellow)
                        .cornerRadius(40.0)
                }
            }
        }
        .padding(20)
        .background(Color.black108)
    }
}

#Preview {
    PraisedView(viewModel: PraisedViewModel())
}
