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
    @ObservedObject var realtimeData: RealtimeDataSource
    var body: some View {
        VStack{
            LineView(data: realtimeData.ekg_value_history, title: "EKG Chart", legend: "Full Screen")
        }.padding(50).onAppear(perform: {
           realtimeData.initializeConnection(ambulance_id: "1111")
            })
    }
}

struct ChartSheet_Previews: PreviewProvider {
    static var previews: some View {
        ChartSheet(realtimeData: RealtimeDataSource()).environmentObject(MainViewModel())
    }
}
