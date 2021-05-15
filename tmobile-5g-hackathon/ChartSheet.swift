//
//  ChartSheet.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/15/21.
//

import SwiftUI
import SwiftUICharts

struct ChartSheet: View {
    @EnvironmentObject var viewModel: MainViewModel
    @StateObject var realtimeData: RealtimeDataSource
    let EKGStylr = ChartStyle(backgroundColor: Color.white, accentColor: Color.purple, gradientColor: GradientColors.green, textColor: Color.black, legendTextColor: Color.gray, dropShadowColor: Color.purple)
    let BP1Stylr = ChartStyle(backgroundColor: Color.white, accentColor: Color.purple, gradientColor: GradientColors.bluPurpl, textColor: Color.black, legendTextColor: Color.gray, dropShadowColor: Color.purple)
    let BP2Stylr = ChartStyle(backgroundColor: Color.white, accentColor: Color.purple, gradientColor: GradientColors.orange, textColor: Color.black, legendTextColor: Color.gray, dropShadowColor: Color.purple)
    
    var body: some View {
        VStack{
            LineView(data: realtimeData.ekg_value_history, title: "EKG Chart", legend: "\(realtimeData.heart_rate) BPM", style: EKGStylr)
            HStack{
                LineView(data: realtimeData.diastolic_blood_pressure_history, title: "Diastolic BP", legend: "\(realtimeData.diastolic_blood_pressure)", style: BP1Stylr)
                LineView(data: realtimeData.systolic_blood_pressure_history, title: "Systolic BP", legend: "\(realtimeData.systolic_blood_pressure)", style: BP2Stylr)
            }
            
            
            
        }.padding(50).onAppear(perform: {
           realtimeData.initializeConnection(ambulance_id: "1111")
        })
    }
}

struct ChartSheet_Previews: PreviewProvider {
    static var previews: some View {
        ChartSheet(realtimeData: RealtimeDataSource()).environmentObject(MainViewModel()).previewLayout(.fixed(width: 1194, height: 834))
    }
}
