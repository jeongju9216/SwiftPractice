//
//  BubbleView.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import SwiftUI

// 말풍선 모델
enum Sender {
    
    case me
    case you
}

enum BubbleState {
    
    case normal
    case loading
    case waiting  // 로딩은 완료됐지만 재생 대기 중
    case playing
}

struct BubbleModel: Identifiable {
    
    let id = UUID()
    let content: String
    let sender: Sender
    var state: BubbleState = .normal
}

struct BubbleView: View {
    
    let bubble: BubbleModel
    let onReplay: (BubbleModel) -> Void
    let isAnyBubbleLoading: Bool
    
    var body: some View {
        HStack {
            if bubble.sender == .me {
                Spacer()
                Text(bubble.content)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    if bubble.state == .loading {
                        Text("Loading...")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else if bubble.state == .waiting {
                        Text("Waiting...")
                            .font(.caption)
                            .foregroundColor(.orange)
                    } else if bubble.state == .playing {
                        Text("Playing...")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text(bubble.content)
                            .padding()
                            .background(backgroundColorForState(bubble.state))
                            .foregroundColor(.black)
                            .cornerRadius(15)
                            .shadow(radius: 3)
                            .animation(.easeInOut(duration: 0.3), value: bubble.state)
                        
                        // 다시듣기 버튼
                        Button(action: {
                            onReplay(bubble)
                        }) {
                            Image(systemName: "speaker.wave.2.circle.fill")
                                .font(.title2)
                                .foregroundColor(isAnyBubbleLoading ? .gray : .blue)
                        }
                        .disabled(isAnyBubbleLoading)
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
    // 상태에 따른 배경색 반환
    private func backgroundColorForState(_ state: BubbleState) -> Color {
        switch state {
        case .normal:
            return .white
        case .loading:
            return .white
        case .waiting:
            return Color.orange.opacity(0.1)  // 대기 중일 때 연한 주황색
        case .playing:
            return Color.blue.opacity(0.2)    // 재생 중일 때 연한 하늘색
        }
    }
}
