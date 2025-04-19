//
//  ChatView.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import SwiftUI

// 채팅 리스트 메인 뷰
struct ChatListView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            // 메시지 리스트
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.bubbles) { bubble in
                            BubbleView(
                                bubble: bubble,
                                onReplay: { bubbleToReplay in
                                    Task {
                                        await viewModel.replayBubble(bubbleToReplay)
                                    }
                                },
                                isAnyBubbleLoading: viewModel.isAnyBubbleLoading
                            )
                            .id(bubble.id)
                        }
                    }
                }
                .onChange(of: viewModel.bubbles.count) {
                    if let lastID = viewModel.bubbles.last?.id {
                        scrollView.scrollTo(lastID, anchor: .bottom)
                    }
                }
            }

            // 입력 필드
            HStack {
                TextField("메시지를 입력하세요", text: $viewModel.inputText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button(action: {
                    Task {
                        await viewModel.sendMessage()
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}
