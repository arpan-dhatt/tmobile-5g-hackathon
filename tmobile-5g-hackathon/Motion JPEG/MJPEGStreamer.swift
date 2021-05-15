//
//  MJPEGStreamer.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/14/21.
//

import SwiftUI

class MJPEGStreamer: ObservableObject {
    @Published var image: UIImage!
    var url: URL
    
    init(stream_url: URL) {
        self.url = stream_url
        self.initializeConnection()
    }
    
    var socketTask: URLSessionWebSocketTask?
    
    func initializeConnection() {
        socketTask = URLSession.shared.webSocketTask(with: self.url)
        
        socketTask?.resume()
        
        self.receive()
        print("begun \(self.url)")
    }
    
    func dropConnection() {
        socketTask?.cancel()
    }
    
    private func receive() {
        self.socketTask?.receive(completionHandler: {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let message):
                switch message {
                case .string(let text):
                    print(text)
                case .data(let data):
                    self?.handle_jpeg(data)
                @unknown default:
                    fatalError()
                }
            }
            self?.receive()
        })
    }
    
    private func handle_jpeg(_ data: Data) {
        let decoded = UIImage(data: data)
        if decoded != nil {
            DispatchQueue.main.async {
                self.image = decoded
            }
        }
    }
}
