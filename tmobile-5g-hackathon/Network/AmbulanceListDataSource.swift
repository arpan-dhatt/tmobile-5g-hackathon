//
//  AmbulanceListDataSource.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

class AmbulanceListDataSource : ObservableObject {
    var demoData = true
    
    @Published var items = [Ambulance]()
    
    private func formURL() -> URL {
        return URL(string: NetConfig.URL_ROOT+"ambulances")!
    }
    
    func loadData() {
        if demoData {
            loadDemo()
        } else {
            loadNetwork()
        }
    }
    
    private func loadNetwork() {
        let url = formURL()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let response_data = try? JSONDecoder().decode(GET_ambulances_Response.self, from: data)
            if let json_data = response_data {
                DispatchQueue.main.async {
                    self.items.removeAll()
                    for item in json_data.ambulances {
                        self.items.append(
                            Ambulance(
                                _id: item._id,
                                name: item.name,
                                going_to: item.going_to,
                                longitude: item.longitude,
                                latitude: item.latitude,
                                arriving_in: item.arriving_in,
                                stream_urls: item.stream_urls
                            )
                        )
                    }
                }
            }
        }
        task.resume()
    }
    
    private func loadDemo() {
        items = [
            Ambulance(_id: "1lkjl31j12lkj31", name: "Demo One", going_to: "scene", longitude: 34.23223, latitude: -23.234433, arriving_in: "12 min", stream_urls: []),
            Ambulance(_id: "1lkjd31j12lkj31", name: "Demo Two", going_to: "trauma center", longitude: 34.23223, latitude: -23.234433, arriving_in: "Unknown", stream_urls: []),
            Ambulance(_id: "1lkja31j12lkj31", name: "Demo Three", going_to: "inactive", longitude: 34.23223, latitude: -23.234433, arriving_in: "4 min", stream_urls: []),
            Ambulance(_id: "1lkja31j12lkj31", name: "Demo Four", going_to: "trauma center", longitude: 34.23223, latitude: -23.234433, arriving_in: "0 min", stream_urls: []),
            Ambulance(_id: "1lkja31j12lkj31", name: "Demo Five", going_to: "scene", longitude: 34.23223, latitude: -23.234433, arriving_in: "Unknown", stream_urls: [])
        ]
    }
}
