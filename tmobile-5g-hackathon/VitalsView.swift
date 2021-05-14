//
//  VitalsView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct VitalsView: View {
    @State private var expanded = false
    @ObservedObject private var dataSource = RealtimeDataSource()
    
    var body: some View {
        if !expanded {
            VStack {
                // ekg / bpm
                HStack {
                    Spacer()
                    Text("\(dataSource.heart_rate)")
                }
                // blood pressure
                HStack {
                    Spacer()
                    Text("\(dataSource.diastolic_blood_pressure)")
                    Text("\(dataSource.systolic_blood_pressure)")
                }
                // blood oxygen
                HStack {
                    Spacer()
                    Text("\(dataSource.heart_rate)")
                }
            }.onAppear(perform: {
                dataSource.demoVitalsData()
            })
        }
        else {
            Text("big!")
        }
    }
}

struct VitalsView_Previews: PreviewProvider {
    static var previews: some View {
        VitalsView().previewLayout(.fixed(width: 1194, height: 834))
    }
}
