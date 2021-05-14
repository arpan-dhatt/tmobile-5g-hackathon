//
//  VideoView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @Namespace private var animation
    private var models = [PlayerViewModel]()
    @State private var selectedIndex: Int?
    @State private var selectedPlayerViewModel: PlayerViewModel?
    
    init(videos: [URL]?) {
        if let videos = videos {
            for video in videos {
                models.append(PlayerViewModel(url: video))
            }
        }
    }
    
    var body: some View {
        if selectedPlayerViewModel == nil {
            if models.count == 4 {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        PlayerContainerView(player: models[0].player, gravity: .aspectFill).matchedGeometryEffect(id: "0", in: animation).onTapGesture {
                            withAnimation {
                                selectedPlayerViewModel = models[0]
                                selectedIndex = 0
                            }
                        }
                        PlayerContainerView(player: models[1].player, gravity: .aspectFill).matchedGeometryEffect(id: "1", in: animation).onTapGesture {
                            withAnimation {
                                selectedPlayerViewModel = models[1]
                                selectedIndex = 1
                            }
                        }
                    }
                    VStack(spacing: 0) {
                        PlayerContainerView(player: models[2].player, gravity: .aspectFill).matchedGeometryEffect(id: "2", in: animation).onTapGesture {
                            withAnimation {
                                selectedPlayerViewModel = models[2]
                                selectedIndex = 2
                            }
                        }
                        PlayerContainerView(player: models[3].player, gravity: .aspectFill).matchedGeometryEffect(id: "3", in: animation).onTapGesture {
                            withAnimation {
                                selectedPlayerViewModel = models[3]
                                selectedIndex = 3
                            }
                        }
                    }
                }
            }
        } else {
            PlayerContainerView(player: selectedPlayerViewModel!.player, gravity: .aspectFill).matchedGeometryEffect(id: "\(selectedIndex!)", in: animation).onTapGesture {
                withAnimation {
                    selectedPlayerViewModel = nil
                    selectedIndex = nil
                }
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videos:[
            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
        ]).previewLayout(.fixed(width: 1194, height: 834))
    }
}

func playingAVPlayer(url: URL) -> AVPlayer {
    let player = AVPlayer(url: url)
    player.play()
    return player
}

enum PlayerGravity {
    case aspectFill
    case resize
}

class PlayerView: UIView {
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    let gravity: PlayerGravity
    
    init(player: AVPlayer, gravity: PlayerGravity) {
        self.gravity = gravity
        super.init(frame: .zero)
        self.player = player
        self.backgroundColor = .black
        setupLayer()
    }
    
    func setupLayer() {
        switch gravity {
    
        case .aspectFill:
            playerLayer.contentsGravity = .resizeAspectFill
            playerLayer.videoGravity = .resizeAspectFill
            
        case .resize:
            playerLayer.contentsGravity = .resize
            playerLayer.videoGravity = .resize
            
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

final class PlayerContainerView: UIViewRepresentable {
    typealias UIViewType = PlayerView
    
    let player: AVPlayer
    let gravity: PlayerGravity
    
    init(player: AVPlayer, gravity: PlayerGravity) {
        self.player = player
        self.gravity = gravity
    }
    
    func makeUIView(context: Context) -> PlayerView {
        return PlayerView(player: player, gravity: gravity)
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) { }
}

class PlayerViewModel: ObservableObject {

    let player: AVPlayer
    
    init(url: URL) {
        self.player = AVPlayer(playerItem: AVPlayerItem(url: url))
        self.play()
    }
    
    func play() {
        let currentItem = player.currentItem
        if currentItem?.currentTime() == currentItem?.duration {
            currentItem?.seek(to: .zero, completionHandler: nil)
        }
        
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
}
