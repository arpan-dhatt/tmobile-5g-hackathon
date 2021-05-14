//
//  ContentView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUICharts
import SwiftUI

struct ContentView: View {
    @State var purpleData: [Double] = [8,32,11,23,40,28]
    @State var currentDate = Date()
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    var body: some View {
        MultiLineChartView(data: [(purpleData, GradientColors.green)], title: "Title", form: ChartForm.extraLarge).onReceive(timer) { input in
            withAnimation {
                purpleData.append(Double.random(in: 40...45))
                if (purpleData.count > 100) {
                    purpleData.remove(at: 0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 1194, height: 834))
    }
}
