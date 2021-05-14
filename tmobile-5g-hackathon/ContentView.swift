//
//  ContentView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct ContentView: View {
    @State private var data = [Double]()
    
    @State private var count: Int = 0
    let timer = Timer.publish(every: 0.16, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            Text("\(count)")
            LineChart(data: $data).stroke(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)).frame(width: 400, height: 400, alignment: .center).onReceive(timer, perform: { _ in
                count += 1
                withAnimation {
                    data.append(Double.random(in: -20.0...20.0))
                    if data.count > 50 {
                        data.remove(at: 0)
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 1194, height: 834))
    }
}
