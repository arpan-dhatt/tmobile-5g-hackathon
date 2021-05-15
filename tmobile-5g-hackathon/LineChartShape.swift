//
//  LineChartShape.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/14/21.
//

import SwiftUI

// some example code is commented at the bottom of this file
// for styling this look at this: https://www.hackingwithswift.com/books/ios-swiftui/paths-vs-shapes-in-swiftui
// strokes can also be gradients if you want them to be (like a left to right gradient with a fade on the left?)
struct LineChartShape: Shape {
    var data: [Double]
    private var maximum: Double {
        return data.max() ?? 0.0
    }
    private var minimum: Double {
        return data.min() ?? 0.0
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if data.count >= 2 {
            var x: CGFloat = rect.minX
            var h: CGFloat = rect.maxY - rect.minY
            var y: CGFloat = (CGFloat(data[0]) - rect.minY) / rect.maxY * h + rect.minY
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            for (i, v) in data[1...].enumerated() {
                x = (rect.maxX - rect.minX) * CGFloat(i+1)/CGFloat(data.count) + rect.minX
                h = rect.maxY - rect.minY
                y = -CGFloat((v - self.minimum) / (self.maximum-self.minimum)) * h + rect.maxY
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
        }
        return path
    }
}

struct LineChartShape_Previews: PreviewProvider {
    static var previews: some View {
        LineChartShape(data: [-100, 100, 100, 100, -100, -50, 500, 750, -50, -10]).stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)).frame(width: 500, height: 100, alignment: .center)
    }
}

//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var data = [Double]()
//
//    @State private var count: Int = 0
//    let timer = Timer.publish(every: 0.16, on: .main, in: .common).autoconnect()
//    var body: some View {
//        VStack {
//            Text("\(count)")
//            LineChart(data: $data).stroke(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)).frame(width: 400, height: 400, alignment: .center).onReceive(timer, perform: { _ in
//                count += 1
//                withAnimation {
//                    data.append(Double.random(in: -20.0...20.0))
//                    if data.count > 50 {
//                        data.remove(at: 0)
//                    }
//                }
//            })
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().previewLayout(.fixed(width: 1194, height: 834))
//    }
//}
