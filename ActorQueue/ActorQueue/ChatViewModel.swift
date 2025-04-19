//
//  ChatViewModel.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import Foundation

@MainActor
final class ChatViewModel: ObservableObject {
    
    @Published var bubbles: [BubbleModel] = []
    @Published var inputText: String = ""
    @Published var isAnyBubbleLoading = false  // 로딩 중인 버블이 있는지 여부

    private var ttsQueueManager: TTSQueueManager!
    private var autoResponseIndex = 0
    
    // 샘플 자동 응답 메시지
    private let autoResponses = [
        "네, 알겠습니다!",
        "더 자세히 설명해주실 수 있나요?",
        "그것은 좋은 아이디어네요.",
        "흥미로운 관점이네요. 더 생각해볼게요.",
        "정확히 이해했습니다. 진행해 볼까요?",
        "다른 대안은 없을까요?",
        "제가 도울 수 있는 일이 있을까요?",
        "이 부분에 대해 더 알려주세요."
    ]
    
    init() {
        ttsQueueManager = TTSQueueManager(viewModel: self)
    }
    
    // 메시지 전송 함수
    // sendMessage 함수 수정
    func sendMessage() async {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        // TTS 큐 초기화 (사용자가 메시지를 보낼 때)
        await ttsQueueManager.resetQueue()
        
        let newMessage = BubbleModel(content: inputText, sender: .me)
        bubbles.append(newMessage)
        inputText = ""
        
        // 자동 응답 생성 (2~4개 랜덤)
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초 대기
        
        // 2~4개의 메시지 생성
        let responseCount = Int.random(in: 2...4)
        var responses: [BubbleModel] = []
        
        for _ in 0..<responseCount {
            let responseText = self.autoResponses[self.autoResponseIndex]
            self.autoResponseIndex = (self.autoResponseIndex + 1) % self.autoResponses.count
            
            let response = BubbleModel(content: responseText, sender: .you)
            bubbles.append(response)
            responses.append(response)
            
            // 연속 메시지 사이에 짧은 딜레이 추가
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3초 딜레이
        }
        
        // 모든 메시지를 한번에 큐에 추가
        await ttsQueueManager.enqueueMultiple(responses)
    }

    func replayBubble(_ bubble: BubbleModel) async {
        // 로딩 중인 버블이 있으면 재생 불가
        if isAnyBubbleLoading {
            return
        }
        
        // 해당 버블만 재생
        await ttsQueueManager.replaySingleBubble(bubble)
    }
    
    // 버블 상태 업데이트 함수 수정
    func updateBubbleState(_ updatedBubble: BubbleModel) {
        if let index = bubbles.firstIndex(where: { $0.id == updatedBubble.id }) {
            bubbles[index].state = updatedBubble.state
        }
        
        // 로딩 중인 버블이 있는지 확인하여 isAnyBubbleLoading 업데이트
        isAnyBubbleLoading = bubbles.contains(where: { $0.state == .loading })
    }

    // 모든 버블 상태를 normal로 리셋
    func resetAllBubbleStates() async {
        for index in bubbles.indices {
            bubbles[index].state = .normal
        }
    }
}
