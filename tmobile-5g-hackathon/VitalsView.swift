//
//  VitalsView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct VitalsView: View {
    @ObservedObject private var dataSource = RealtimeDataSource()
    
    var body: some View {
        HStack {
            VStack(spacing: 20) {
                LineChartShape(data: dataSource.ekg_value_history, maximum: 7.0, minimum: -3).stroke(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.red, Color.red]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)).frame(width: 200, height: 50, alignment: .center)
                LineChartShape(data: dataSource.systolic_blood_pressure_history, maximum: 122, minimum: 78).stroke(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.yellow, Color.yellow]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)).frame(width: 200, height: 50, alignment: .center).background(
                    LineChartShape(data: dataSource.diastolic_blood_pressure_history, maximum: 122, minimum: 78).stroke(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.orange, Color.orange]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)).frame(width: 200, height: 50, alignment: .center))
                LineChartShape(data: dataSource.blood_oxygen_percent_history, maximum: 100, minimum: 85).stroke(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.blue, Color.blue]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)).frame(width: 200, height: 33, alignment: .center)
            }.padding(.trailing, 10)
            VStack(spacing: 40) {
                // ekg / bpm
                HStack(spacing:0) {
                    Text("\(Int(dataSource.heart_rate))").font(.largeTitle)
                    VStack{
                        Text("BPM")
                        Image(systemName: "suit.heart.fill").foregroundColor(.red)
                    }
                    Spacer()
                }
                // blood pressure
                HStack(spacing:0) {
                    Text("\(Int(dataSource.diastolic_blood_pressure))").font(.largeTitle)
                    Text("/").font(.largeTitle)
                    Text("\(Int(dataSource.systolic_blood_pressure))").font(.largeTitle)
                    Spacer()
                }
                // blood oxygen
                HStack(spacing:5) {
                    Text("\(Int(dataSource.blood_oxygen_percent))%").font(.largeTitle)
                    Text("O2")
                        .foregroundColor(.blue)
                        .bold()
                        .font(.title)
                    Spacer()
                }
            }.onAppear(perform: {
                dataSource.initializeConnection(ambulance_id: "1111")
            })
        }
    }
}

struct VitalsView_Previews: PreviewProvider {
    static var previews: some View {
        VitalsView().frame(width: 375, height: 200, alignment: .center)
        
    }
}
