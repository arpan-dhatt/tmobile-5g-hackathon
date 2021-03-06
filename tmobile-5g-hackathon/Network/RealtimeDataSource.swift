//
//  RealtimeDataSource.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

class RealtimeDataSource: ObservableObject {
    @Published var ekg_value_history = [Double]()
    var ekg_value: Double {
        if let item = ekg_value_history.last {
            return item
        } else {
            return 0;
        }
    }
    
    @Published var heart_rate_history = [Double]()
    var heart_rate: Double {
        if let item = heart_rate_history.last {
            return item
        } else {
            return 0;
        }
    }
    
    @Published var blood_oxygen_percent_history = [Double]()
    var blood_oxygen_percent: Double {
        if let item = blood_oxygen_percent_history.last {
            return item
        } else {
            return 0;
        }
    }
    
    @Published var diastolic_blood_pressure_history = [Double]()
    var diastolic_blood_pressure: Double {
        if let item = diastolic_blood_pressure_history.last {
            return item
        } else {
            return 0;
        }
    }
    
    @Published var systolic_blood_pressure_history = [Double]()
    var systolic_blood_pressure: Double {
        if let item = systolic_blood_pressure_history.last {
            return item
        } else {
            return 0;
        }
    }
    
    
    @Published var transferred_files:[TransferredFile] = [.init(time_ms: 100, type: "EKG", images: [UIImage(named: "A")!]), .init(time_ms: 100, type: "EKG", images: [UIImage(named: "B")!])]
    
    var socketTask: URLSessionWebSocketTask?
    
    func initializeConnection(ambulance_id: String) {
        let url = NetConfig.WS_ROOT+"\(ambulance_id)"
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
            self?.receive()
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
        DispatchQueue.main.async {
            if let ekg_value = data.ekg_value { self.ekg_value_history.append(ekg_value) }
            if let heart_rate = data.heart_rate { self.heart_rate_history.append(heart_rate) }
            if let blood_oxygen_percent = data.blood_oxygen_percent { self.blood_oxygen_percent_history.append(blood_oxygen_percent) }
            if let diastolic_blood_pressure = data.diatolic_blood_pressure { self.diastolic_blood_pressure_history.append(diastolic_blood_pressure) }
            if let systolic_blood_pressure = data.sysstolic_blood_pressure { self.systolic_blood_pressure_history.append(systolic_blood_pressure) }
            let maxCount = 100;
            if self.ekg_value_history.count > maxCount {
                self.ekg_value_history.remove(at: 0)
            }
            if self.heart_rate_history.count > maxCount {
                self.heart_rate_history.remove(at: 0)
            }
            if self.blood_oxygen_percent_history.count > maxCount {
                self.blood_oxygen_percent_history.remove(at: 0)
            }
            if self.diastolic_blood_pressure_history.count > maxCount {
                self.diastolic_blood_pressure_history.remove(at: 0)
            }
            if self.systolic_blood_pressure_history.count > maxCount {
                self.systolic_blood_pressure_history.remove(at: 0)
            }
        }
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
    
    func demoVitalsData() {
        for i in 0...20 {
            ekg_value_history.append(Double.random(in: -10...10))
            heart_rate_history.append(Double.random(in: 170...190))
            blood_oxygen_percent_history.append(Double.random(in: 95...100))
            diastolic_blood_pressure_history.append(Double.random(in: 130...160))
            systolic_blood_pressure_history.append(Double.random(in: 60...90))
        }
    }
}
