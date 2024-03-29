//
//  ExtraPraisingView.swift
//  QiitaHackthonApp
//
//  Created by HONG JEONGSEOB on 2024/02/11.
//

import SwiftUI

struct ExtraPraisingView: View {
    @ObservedObject var viewModel: ExtraPraisingViewModel
    @State var showingBottomSheet = false

    var attributedUserName: AttributedString {
        var result = AttributedString("\(viewModel.praisedUser?.name ?? "")")
        result.font = .title2
        result.foregroundColor = .yellow103
        return result
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("nice_pass")
                Image("load")
                    .frame(height: 0)
                    .offset(y: 130)
                VStack(spacing: -15) {
                    HStack {
                        AsyncImage(url: URL(string: viewModel.praisingUser?.profileImageUri ?? "")) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        } placeholder: {
                            Image("cat")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }

                        AsyncImage(url: URL(string: viewModel.praisedUser?.profileImageUri ?? "")) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .offset(x: 30, y: -18)
                        } placeholder: {
                            Image("cat")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .offset(x: 30, y: -18)
                        }
                    }
                    Image("duo_body")
                }
                Spacer(minLength: 40)
                Text("\(attributedUserName)さんに\n素敵バトンが渡りました")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.yellow103)
                    VStack {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))]) {
                            ForEach($viewModel.stamps, id: \.self) { stamp in
                                StampView(didTap: viewModel.addReactionStamp, reactionStamp: stamp.reactionStamp, number: stamp.count)
                            }
                            Button(action: {
                                print("tap buton")
                                showingBottomSheet.toggle()
                            }) {
                                PlusView()
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
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray100)
                    VStack(alignment: .leading) {
                        TextField("コメント入力", text: $viewModel.inputMessage)
                            .foregroundStyle(Color.grayText)
                        HStack {
                            Spacer()
                            AsyncImage(url: URL(string: viewModel.myUser?.profileImageUri ?? "")) { image in
                                image.resizable().scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                            Text(viewModel.myUser?.name ?? "")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white107)
                        }
                    }
                    .padding(20)
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.postComment()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40, style: .continuous)
                                    .fill(Color.gray44444)
                                    .padding(4)
                                Text("+ コメント")
                                    .font(.system(size: 16))
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 128, height: 48)
                        }
                    }
                    .offset(y: -55)
                }
            }
        }
        .padding(20)
        .background(Color.black108)
        .sheet(isPresented: $showingBottomSheet) {
            BottomSheetView(didTap: viewModel.addReactionStamp)
                .presentationDetents([.height(100), .fraction(10)])
        }
        .ignoresSafeArea()
    }
}

struct BottomSheetView: View {
    var didTap: (ReactionStamp) -> Void
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(ReactionStamp.allCases, id: \.self) { stamp in
                    Button(action: {
                        didTap(stamp)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray100)
                            Image(stamp.rawValue)
                        }
                        .frame(width: 48, height: 48)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ExtraPraisingView(viewModel: ExtraPraisingViewModel())
}
