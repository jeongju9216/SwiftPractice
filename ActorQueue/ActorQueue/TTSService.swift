//
//  TTSService.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import Foundation
import Combine

// TTS 응답 모델
struct TTSResponse {
    
    let bubbleId: UUID
    let audioData: String  // 실제로는 Data 타입이겠지만 샘플이므로 String으로 대체
}

// TTS 서비스 (샘플 구현)
actor TTSService {
    
    // 가상의 TTS 응답 데이터 저장
    private var ttsResponses: [UUID: String] = [:]
    
    // TTS 요청 시뮬레이션 (0.1~3초 랜덤 딜레이)
    func requestTTS(for text: String, bubbleId: UUID) async -> TTSResponse {
        let delay = Double.random(in: 0.1...3.0)
        
        // 비동기 대기
        try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        
        // 가상의 오디오 데이터 생성 및 저장
        let audioData = "TTS_AUDIO_\(text)_\(Int.random(in: 1000...9999))"
        ttsResponses[bubbleId] = audioData
        
        return TTSResponse(bubbleId: bubbleId, audioData: audioData)
    }
    
    // TTS 재생 시뮬레이션 (3~5초 랜덤 재생)
    func playTTS(bubbleId: UUID) async {
        guard ttsResponses[bubbleId] != nil else { return }
        
        let playTime = Double.random(in: 3.0...5.0)
        try? await Task.sleep(nanoseconds: UInt64(playTime * 1_000_000_000))
    }
    
    // 특정 TTS 응답 삭제
    func removeTTSResponse(for bubbleId: UUID) {
        ttsResponses[bubbleId] = nil
    }
    
    // 모든 TTS 응답 초기화
    func clearAllResponses() {
        ttsResponses.removeAll()
    }
    
    // 특정 버블 ID에 대한 TTS 응답이 있는지 확인
    func hasTTSResponse(for bubbleId: UUID) -> Bool {
        return ttsResponses[bubbleId] != nil
    }
}
