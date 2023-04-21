import UIKit

//Product
protocol Player {
    var content: String { get set }
        
    func play()
    func pause()
}

// Concrete Product
struct MusicPlayer: Player {
    var content: String
    
    func play() {
        print("[MusicPlayer] Play \(content)")
    }
    
    func pause() {
        print("[MusicPlayer] Pause")
    }
}

// Concrete Product
struct VideoPlayer: Player {
    var content: String
    
    func play() {
        print("[VideoPlayer] Play \(content)")
    }
    
    func pause() {
        print("[VideoPlayer] Pause")
    }
}

// Creator
protocol PlayerCreator {
    func createPlayer(content: String, contentType: ContentType) -> Player
}

enum ContentType {
    case music
    case video
}

// Factory (Concrete Creator)
final class PlayerFactory: PlayerCreator {
    func createPlayer(content: String, contentType: ContentType) -> Player {
        switch contentType {
        case .music:
            return MusicPlayer(content: content)
        case .video:
            return VideoPlayer(content: content)
        }
    }
}

let playerFactory = PlayerFactory()

let musicPlayer = playerFactory.createPlayer(content: "차이콥스키 바이올린 협주곡 D단조", contentType: .music)
let videoPlayer = playerFactory.createPlayer(content: "타이타닉", contentType: .video)

musicPlayer.play() //[MusicPlayer] Play
musicPlayer.pause() //[MusicPlayer] Pause

videoPlayer.play() //[VideoPlayer] Play
videoPlayer.pause() //[VideoPlayer] Pause
