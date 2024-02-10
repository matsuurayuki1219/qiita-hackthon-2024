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

                Spacer()
                Button(action: {
                    print("tap buton")
                }) {
                    Text("次のバトンへつなぐ").fontWeight(.bold)
                }
                .buttonStyle(MyButtonStyle())

            }
        }
        .padding(20)
        .background(Color.black108)
    }
}

struct StampStackView: View {
    @Binding var stamps: [Stamp]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))]) {
            ForEach($stamps, id: \.self) { stamp in
                StampView(imageName: stamp.imageName, number: stamp.count)
            }
            Button(action: {
                print("tap buton")
            }) {
                PlusView()
            }
        }
    }
}

struct LeadCommentView: View {
    @Binding var stamps: [Stamp]
    @Binding var comment: String
    @Binding var userName: String
    @Binding var userImageName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.yellow103)
            VStack {
                StampStackView(stamps: $stamps).offset(y: -40)

                Group {
                    Text(comment)
                        .foregroundStyle(Color.gray100)
                    HStack {
                        Spacer()
                        Image(userImageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        Text(userName)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.gray100)
                    }
                }
                .offset(y: -20)
            }
            .padding(20)
        }
    }
}

struct CommentView: View {
    @Binding var comment: String
    @Binding var userName: String
    @Binding var userImageName: String

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

struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .padding()
        .foregroundColor(Color.black108)
        .background(.yellow)
        .cornerRadius(40.0)
        .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
        .opacity(configuration.isPressed ? 0.4 : 1)
    }
}

#Preview {
    PraisedView(viewModel: PraisedViewModel())
}
