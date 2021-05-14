//
//  MainView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct MainView: View {
    @Namespace private var animation
    @State private var vitalViewExpanded = false
    var body: some View {
        ZStack {
            if vitalViewExpanded {
                Text("jkjlkljkl")
                    .frame(width: 400, height: 400).background(RoundedRectangle(cornerRadius: 25.0, style: .continuous).fill(Color.blue).matchedGeometryEffect(id: "VitalsView", in: animation)).onTapGesture {
                        withAnimation {
                            vitalViewExpanded.toggle()
                        }
                    }
            }
            if !vitalViewExpanded {
                HStack {
                    Spacer()
                    VStack {
                        
                        Text("").frame(width: 200, height: 200).background(RoundedRectangle(cornerRadius: 25.0, style: .continuous).fill(Color.blue).matchedGeometryEffect(id: "VitalsView", in: animation)).onTapGesture {
                            withAnimation {
                                vitalViewExpanded.toggle()
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewLayout(.fixed(width: 1194, height: 834))
    }
}
