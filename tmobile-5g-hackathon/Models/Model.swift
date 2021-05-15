//
//  Models.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import UIKit

struct Ambulance: Decodable {
    var _id: String
    var name: String
    var going_to: String
    var longitude: Float
    var latitude: Float
    var arriving_in: String
    var stream_urls: [String]
}

struct DataPoint<T> {
    var time_ms: Int64
    var value: T
}

struct TransferredFile {
    var id = UUID()
    var time_ms: Int64
    var type: String
    var images: [UIImage]
}
