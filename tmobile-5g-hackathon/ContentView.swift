//
//  ContentView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VideoView(videos:[
//            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
//            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
//            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
//            URL(string: "https://56cdb389b57ec.streamlock.net:1935/nps/faithful.stream/playlist.m3u8")!,
//        ]).ignoresSafeArea()
//        MJPEGView(URL(string: "")!)
//        VitalsView()
//        FileEditor(file: .init(time_ms: 100, type: "EKG", images: [UIImage(named: "1")!]))
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 1194, height: 834)).environmentObject(MainViewModel())
    }
}
