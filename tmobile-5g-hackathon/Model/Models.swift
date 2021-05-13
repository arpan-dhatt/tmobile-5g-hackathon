//
//  Models.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import Foundation

struct Ambulance: Decodable {
    var _id: String
    var name: String
    var going_to: String
    var longitude: Float
    var latitude: Float
    var arriving_in: String
    var stream_urls: [String]
}
