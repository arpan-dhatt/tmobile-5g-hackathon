//
//  NetworkModels.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import Foundation

// GET /ambulances
struct GET_ambulances_Response: Decodable {
    var ambulances: [Ambulance]
}

// ambulance data
struct GET_ambulances_Response_item: Decodable {
    var _id: String
    var name: String
    var going_to: String
    var longitude: Float
    var latitude: Float
    var arriving_in: String
    var stream_urls: [String]
}

// WS /ambulance_data?ambulance_id=3342342342342423 VITALS_UPDATE
struct WS_VITALS_UPDATE: Decodable {
    var time_ms: Int64
    var ekg_value: Double?
    var heart_rate: Double?
    var blood_oxygen_percent: Double?
    var diatolic_blood_pressure: Double?
    var sysstolic_blood_pressure: Double?
}

// WS /ambulance_data?ambulance_id=3342342342342423 NEW_FILE
struct WS_NEW_FILE: Decodable {
    var time_ms: Int64
    var type: String
    var image_urls: [String]
}
