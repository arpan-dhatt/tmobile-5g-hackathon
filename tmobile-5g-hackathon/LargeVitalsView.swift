//
//  LargeVitalsView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct LargeVitalsView: View {
    var animation: Namespace.ID?
    var body: some View {
        Text("Hello how are you doing").frame(width: 400, height: 400).background(Color.purple).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).matchedGeometryEffect(id: "VitalsView", in: animation!)
    }
}

struct LargeVitalsView_Previews: PreviewProvider {
    static var previews: some View {
        LargeVitalsView().previewLayout(.fixed(width: 1194, height: 834))
    }
}
