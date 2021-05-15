//
//  MainViewModel.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var currentAmbulance: Ambulance? = nil
    @Published var currentFile: TransferredFile? = nil
    @Published var showVitals = false
}
