//
//  NLineChart.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/14/21.
//

import SwiftUI

struct LineChart: Shape {
    @Binding var data: [Double]
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

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(data: .constant([-100, 100, 100, 100, -100, -50, 500, 750, -50, -10])).stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)).frame(width: 500, height: 100, alignment: .center)
    }
}
