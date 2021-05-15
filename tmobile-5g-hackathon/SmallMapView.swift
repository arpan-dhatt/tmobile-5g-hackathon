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
    @State private var region: MKCoordinateRegion
    @EnvironmentObject var viewModel: MainViewModel
    
    var pins = [pin]()
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        pins.append(.init(coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: pins) {
            MapPin(coordinate: $0.coordinates)
        }.frame(width: 200, height: 200).cornerRadius(25.0)
    }
}

struct SmallMapView_Previews: PreviewProvider {
    static var previews: some View {
        SmallMapView(latitude: 0, longitude: 0).previewLayout(.fixed(width: 1194, height: 834)).environmentObject(MainViewModel())
    }
}
