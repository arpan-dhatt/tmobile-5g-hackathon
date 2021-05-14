//
//  SmallVitalsView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct SmallVitalsView: View {
    var animation: Namespace.ID?
    var body: some View {
        Text("Hello how are you doing").frame(width: 200, height: 200).background(Color.purple).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).matchedGeometryEffect(id: "VitalsView", in: animation!)
    }
}

struct SmallVitalsView_Previews: PreviewProvider {
    static var previews: some View {
        SmallVitalsView().previewLayout(.fixed(width: 1194, height: 834))
    }
}
