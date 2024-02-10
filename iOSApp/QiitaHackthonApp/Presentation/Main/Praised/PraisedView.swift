//
//  PraisedView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/10.
//

import SwiftUI

struct PraisedView: View {
    @ObservedObject var viewModel: PraisedViewModel

    var attributedPraisedUserName: AttributedString {
        var result = AttributedString("\(viewModel.praisedUser?.name ?? "")")
        result.font = .title2
        result.foregroundColor = .yellow103
        return result
    }

    var attributedPraisingUserName: AttributedString {
        var result = AttributedString("\(viewModel.praisingUser?.name ?? "")")
        result.font = .title2
        result.foregroundColor = .yellow103
        return result
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("good_baton")
                Image("load")
                    .frame(height: 0)
                    .offset(y: 180)

                VStack(spacing: -15) {
                    AsyncImage(url: URL(string: viewModel.praisedUser?.profileImageUri ?? "")) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        Image("cat")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    Image("solo_body")
                }
                Spacer(minLength: 40)
                Text("\(attributedPraisedUserName)さんの素敵さを\(attributedPraisingUserName)さんが\nみんなにシェアしました")
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
                            Text(viewModel.praisingUserMessage?.message ?? "")
                                .foregroundStyle(Color.gray100)
                                .multilineTextAlignment(.leading)
                            HStack {
                                Spacer()
                                AsyncImage(url: URL(string: viewModel.praisingUserMessage?.user.profileImageUri ?? "")) { image in
                                    image.resizable().scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(viewModel.praisingUserMessage?.user.name ?? "")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.gray100)
                            }
                        }
                        .offset(y: -20)
                    }
                    .padding(20)
                }

                ForEach(viewModel.extraUserMessages, id: \.self) { message in
                    CommentView(
                        comment: message.message,
                        userName: message.user.name,
                        userImageName: message.user.profileImageUri
                    )
                }

                Spacer()
                Button(action: {
                    print("tap buton")
                    viewModel.navigateToPraising()
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
        .ignoresSafeArea()
    }
}

#Preview {
    PraisedView(viewModel: PraisedViewModel())
}
