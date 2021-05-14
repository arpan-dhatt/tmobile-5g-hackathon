//
//  VideoView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var videos: [URL]?
    var body: some View {
        if videos?.count == 4 {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    VideoPlayer(player: playingAVPlayer(url: videos![0]))
                    VideoPlayer(player: playingAVPlayer(url: videos![1]))
                }
                VStack(spacing: 0) {
                    VideoPlayer(player: playingAVPlayer(url: videos![2]))
                    VideoPlayer(player: playingAVPlayer(url: videos![3]))
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
