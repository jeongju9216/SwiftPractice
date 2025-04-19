//
//  AudioPlayerManager.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import Foundation

// 오디오 재생 관리자
actor AudioPlayerManager {
    
    private var currentlyPlayingId: UUID?
    private var isPlaying = false
    private var playbackTask: Task<Void, Never>?
    
    // 오디오 재생 시작
    func startPlaying(bubbleId: UUID) {
        currentlyPlayingId = bubbleId
        isPlaying = true
        
        // 재생 완료 태스크를 저장
        playbackTask = Task {
            // 실제로는 여기서 오디오 재생 이벤트를 모니터링
        }
    }
    
    // 오디오 재생 종료
    func stopPlaying() {
        currentlyPlayingId = nil
        isPlaying = false
        playbackTask?.cancel()
        playbackTask = nil
    }
    
    // 재생 완료 대기 함수 추가
    func waitForPlaybackCompletion() async {
        await playbackTask?.value
    }
    
    // 현재 재생 중인지 확인
    func isCurrentlyPlaying(bubbleId: UUID) -> Bool {
        return currentlyPlayingId == bubbleId && isPlaying
    }
}

