//
//  MainViewModel.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var currentAmbulance = Ambulance.init(_id: "none", name: "none", going_to: "none", longitude: 50.0, latitude: 51.0, arriving_in: "never", stream_urls: [])
}


