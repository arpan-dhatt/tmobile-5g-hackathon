//
//  RealtimeDataSource.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

class RealtimeDataSource: ObservableObject {
    @Published var ekg_value_history = [DataPoint<Float>]()
    var ekg_value: Float {
        if let item = ekg_value_history.last {
            return item.value
        } else {
            return 0;
        }
    }
    
    @Published var blood_oxygen_percent_history = [DataPoint<Int>]()
    var blood_oxygen_percent: Int {
        if let item = blood_oxygen_percent_history.last {
            return item.value
        } else {
            return 0;
        }
    }
    
    @Published var diastolic_blood_pressure_history = [DataPoint<Int>]()
    var diastolic_blood_pressure: Int {
        if let item = diastolic_blood_pressure_history.last {
            return item.value
        } else {
            return 0;
        }
    }
    
    @Published var systolic_blood_pressure_history = [DataPoint<Int>]()
    var systolic_blood_pressure: Int {
        if let item = systolic_blood_pressure_history.last {
            return item.value
        } else {
            return 0;
        }
    }
    
    
    @Published var transferred_files = [TransferredFile]()
    
    var socketTask: URLSessionWebSocketTask?
    
    func initializeConnection(ambulance_id: String) {
        let url = NetConfig.WS_ROOT+"ambulance_id=\(ambulance_id)"
        print(url)
        socketTask = URLSession.shared.webSocketTask(with: URL(string: url)!)
        
        socketTask?.resume()
        
        receive()
        print("begun")
    }
    
    func dropConnection() {
        socketTask?.cancel()
    }
    
    private func receive() {
        self.socketTask?.receive { [weak self] result in
            print(result)
            switch result {
            case .failure(let error):
                print(error)
            case .success(let message):
                switch message{
                case .string(let text):
                    self?.handleReception(text)
                default:
                    print("Non-text message received")
                }
            }
        }
    }
    
    func handleReception(_ text: String) {
        let event_name = text.components(separatedBy: "||||")[0]
        print(event_name)
        let event_data = text.components(separatedBy: "||||")[1].data(using: .ascii)!
        print(event_data)
        switch event_name {
        case "VITALS_UPDATE":
            if let data = try? JSONDecoder().decode(WS_VITALS_UPDATE.self, from: event_data) {
                VITALS_UPDATE_Handler(data: data)
            }
        case "NEW_FILE":
            if let data = try? JSONDecoder().decode(WS_NEW_FILE.self, from: event_data) {
                NEW_FILE_Handler(data: data)
            }
        default:
            print(event_name)
        }
    }
    
    func VITALS_UPDATE_Handler(data: WS_VITALS_UPDATE) {
        self.ekg_value_history.append(DataPoint(time_ms: data.time_ms, value: data.ekg_value))
        self.blood_oxygen_percent_history.append(DataPoint(time_ms: data.time_ms, value: data.blood_oxygen_percent))
        self.diastolic_blood_pressure_history.append(DataPoint(time_ms: data.time_ms, value: data.diastolic_blood_pressure))
        self.systolic_blood_pressure_history.append(DataPoint(time_ms: data.time_ms, value: data.systolic_blood_pressure))
    }
    
    func NEW_FILE_Handler(data: WS_NEW_FILE) {
        DispatchQueue.global().async {
            var images = [UIImage]()
            for image_url in data.image_urls {
                if let url = URL(string: image_url) {
                    if let imageData = try? Data(contentsOf: url) {
                        if let image = UIImage(data: imageData) {
                            images.append(image)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.transferred_files.append(
                    TransferredFile(time_ms: data.time_ms, type: data.type, images: images)
                )
            }
        }
    }
}