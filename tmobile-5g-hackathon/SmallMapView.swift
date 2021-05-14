//
//  SmallMapView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI
import MapKit

struct pin: Identifiable {
    var id = UUID()
    var coordinates: CLLocationCoordinate2D
}

struct SmallMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.8998, longitude: -97.0403), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    @EnvironmentObject var viewModel: MainViewModel
    
    var pins = [pin]()
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: pins) {
            MapPin(coordinate: $0.coordinates)
        }.frame(width: 400, height: 400).cornerRadius(25.0).overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.black, lineWidth: 2))
    }
}

struct SmallMapView_Previews: PreviewProvider {
    static var previews: some View {
        SmallMapView(pins: [.init(coordinates: CLLocationCoordinate2D(latitude: 32.8998, longitude: -97.0403))]).previewLayout(.fixed(width: 1194, height: 834)).environmentObject(MainViewModel())
    }
}
