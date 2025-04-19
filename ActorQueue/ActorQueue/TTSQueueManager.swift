//
//  TTSQueueManager.swift
//  ActorQueue
//
//  Created by 유정주 on 4/19/25.
//

import Foundation
import Combine

// TTS 큐 관리자
actor TTSQueueManager {
    private var queue: [BubbleModel] = []
    private var loadingCompletedIndices: [Int] = []  // 로딩이 완료된 인덱스 목록
    private var currentPlayingIndex = -1  // 현재 재생 중인 인덱스
    private var isLoading = false  // 현재 로딩 중인지 여부
    private var nextLoadingIndex = 0  // 다음 로딩할 인덱스
    
    private let ttsService = TTSService()
    private let audioPlayerManager = AudioPlayerManager()
    
    private var processingTask: Task<Void, Never>?
    private var playingTask: Task<Void, Never>?
    private var loadingTask: Task<Void, Never>?
    
    private var viewModel: ChatViewModel?
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    // 큐에 메시지 추가
    func enqueue(_ bubble: BubbleModel) {
        queue.append(bubble)
        
        // 첫 메시지라면 로딩 및 재생 프로세스 시작
        if queue.count == 1 {
            startProcessing()
        }
    }
    
    // 메시지 처리 시작
    private func startProcessing() {
        loadingTask = Task { await startLoading() }
        playingTask = Task { await startPlaying() }
    }
    
    // 큐 초기화
    func resetQueue() async {
        // 모든 작업 취소
        processingTask?.cancel()
        loadingTask?.cancel()
        playingTask?.cancel()
        
        // 큐 및 상태 초기화
        queue.removeAll()
        loadingCompletedIndices.removeAll()
        currentPlayingIndex = -1
        isLoading = false
        nextLoadingIndex = 0
        
        // TTS 서비스 초기화
        await ttsService.clearAllResponses()
        await audioPlayerManager.stopPlaying()
        
        // 모든 말풍선 상태 초기화
        await viewModel?.resetAllBubbleStates()
    }
    
    private func startLoading() async {
        while nextLoadingIndex < queue.count {
            let index = nextLoadingIndex
            let bubble = queue[index]
            
            // 로딩 상태로 변경
            var loadingBubble = bubble
            loadingBubble.state = .loading
            await viewModel?.updateBubbleState(loadingBubble)
            
            // 작업 취소 확인
            if Task.isCancelled { return }
            
            // TTS 요청 (로딩)
            isLoading = true
            let ttsResponse = await ttsService.requestTTS(for: bubble.content, bubbleId: bubble.id)
            isLoading = false
            
            // 작업 취소 확인
            if Task.isCancelled { return }
            
            // 로딩 완료된 인덱스 추가
            loadingCompletedIndices.append(index)
            
            // 로딩 완료 후 waiting 상태로 변경 (첫 번째 메시지이고 현재 재생 중인 메시지가 없을 경우 제외)
            if index > 0 || currentPlayingIndex >= 0 {
                var waitingBubble = bubble
                waitingBubble.state = .waiting
                await viewModel?.updateBubbleState(waitingBubble)
            }
            
            // 다음 로딩 인덱스 업데이트
            nextLoadingIndex += 1
        }
    }
    
    // 재생 프로세스
    private func startPlaying() async {
        while currentPlayingIndex < queue.count - 1 {
            // 다음 재생할 인덱스
            let nextPlayIndex = currentPlayingIndex + 1
            
            // 해당 인덱스가 로딩 완료될 때까지 대기
            while !loadingCompletedIndices.contains(nextPlayIndex) {
                if Task.isCancelled { return }
                try? await Task.sleep(nanoseconds: 100_000_000) // 0.1초마다 확인
            }
            
            // 작업 취소 확인
            if Task.isCancelled { return }
            
            // 이전 재생 상태 정상으로 변경 (첫 메시지가 아닌 경우)
            if currentPlayingIndex >= 0 {
                var prevBubble = queue[currentPlayingIndex]
                prevBubble.state = .normal
                await viewModel?.updateBubbleState(prevBubble)
            }
            
            // 현재 메시지 재생 상태로 변경
            currentPlayingIndex = nextPlayIndex
            var playingBubble = queue[currentPlayingIndex]
            playingBubble.state = .playing
            await viewModel?.updateBubbleState(playingBubble)
            
            // 오디오 재생 시작
            await audioPlayerManager.startPlaying(bubbleId: playingBubble.id)
            
            // TTS 재생
            await ttsService.playTTS(bubbleId: playingBubble.id)
            
            // 재생 완료 후 오디오 정지
            await audioPlayerManager.stopPlaying()
            
            // 작업 취소 확인
            if Task.isCancelled { return }
        }
        
        // 마지막 메시지 재생 완료 후 상태 정상으로 변경
        if currentPlayingIndex >= 0 && currentPlayingIndex < queue.count {
            var lastBubble = queue[currentPlayingIndex]
            lastBubble.state = .normal
            await viewModel?.updateBubbleState(lastBubble)
        }
    }
    
    // 메시지 여러 개 추가 (배열)
    func enqueueMultiple(_ bubbles: [BubbleModel]) async {
        if queue.isEmpty && bubbles.count > 0 {
            queue = bubbles
            startProcessing()
        } else {
            queue.append(contentsOf: bubbles)
        }
    }
    
    func replaySingleBubble(_ bubble: BubbleModel) async {
        // 현재 진행 중인 작업 모두 취소
        processingTask?.cancel()
        loadingTask?.cancel()
        playingTask?.cancel()
        
        // 모든 메시지 상태 normal로 리셋
        await viewModel?.resetAllBubbleStates()
        
        // 오디오 재생 중지
        await audioPlayerManager.stopPlaying()
        
        // 큐 및 상태 초기화 (완전한 초기화는 하지 않음)
        currentPlayingIndex = -1
        
        // 이미 TTS 데이터가 있는지 확인
        let hasTTSData = await ttsService.hasTTSResponse(for: bubble.id)
        
        if !hasTTSData {
            // TTS 데이터가 없는 경우, 로딩 후 재생
            var loadingBubble = bubble
            loadingBubble.state = .loading
            await viewModel?.updateBubbleState(loadingBubble)
            
            // TTS 요청
            let ttsResponse = await ttsService.requestTTS(for: bubble.content, bubbleId: bubble.id)
        }
        
        // 재생 상태로 변경
        var playingBubble = bubble
        playingBubble.state = .playing
        await viewModel?.updateBubbleState(playingBubble)
        
        // 오디오 재생
        await audioPlayerManager.startPlaying(bubbleId: bubble.id)
        await ttsService.playTTS(bubbleId: bubble.id)
        await audioPlayerManager.stopPlaying()
        
        // 재생 완료 후 normal 상태로 변경
        var normalBubble = bubble
        normalBubble.state = .normal
        await viewModel?.updateBubbleState(normalBubble)
    }
}
