//
//  MJPEGView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/14/21.
//

import SwiftUI

struct MJPEGView: View {
    @ObservedObject var streamer: MJPEGStreamer
    
    init(_ stream_url: URL) {
        print("hi")
        self.streamer = MJPEGStreamer(stream_url: stream_url)
    }
    
    init(_ streamer: MJPEGStreamer) {
        self.streamer = streamer
    }
    
    var body: some View {
        if let image = streamer.image {
            Image(uiImage: image).resizable()
        }
    }
}

struct MJPEGView_Previews: PreviewProvider {
    static var previews: some View {
        MJPEGView(URL(string: "ws://192.168.86.26:8000/client/1111")!)
    }
}
