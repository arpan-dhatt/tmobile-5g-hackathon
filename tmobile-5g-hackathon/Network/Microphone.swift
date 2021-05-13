//
//  File.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import AVFoundation
import SwiftUI

class Microphone: ObservableObject {
    @Published var recordingAllowed = false
    @Published var recording = false
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioDataBuffer: URL!
        
    init() {
        self.recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [weak self] allowed in
                DispatchQueue.main.async {
                    self?.recordingAllowed = true
                }
            }
        } catch {
            // failed to record
        }
    }
    
    func startStreaming() {
        audioDataBuffer = getDataLocation().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioDataBuffer, settings: settings)
            audioRecorder.delegate = nil
            audioRecorder.record()
            recording = true
        } catch {
            finishStreaming(success: false)
        }
    }
    
    func getDataLocation() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishStreaming(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        recording = false
    }
    
    private func connectToServer(ambulance_id: String) {
        if let url = URL(string: NetConfig.URL_ROOT+"recorded?ambulance_id=\(ambulance_id)") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = URLSession.shared.uploadTask(with: request, fromFile: audioDataBuffer)
            task.resume()
        }
    }
}
