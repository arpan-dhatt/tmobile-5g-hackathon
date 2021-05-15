//
//  MainView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: MainViewModel
    @Namespace private var animation
    @State var selectedItem: String?
    @State var selectedItemID: String?
    
    var body: some View {
        ZStack {
            if viewModel.currentAmbulance == nil {
                AmbulanceSelectorView()
            }
            else {
                if selectedItem == nil {
                    HStack(spacing:0) {
                        VStack(spacing:0) {
                            Image("1").resizable().matchedGeometryEffect(id: "a", in: animation).onTapGesture {
                                withAnimation {
                                    selectedItem = "1"
                                    selectedItemID = "a"
                                }
                            }
                            Image("1").resizable().matchedGeometryEffect(id: "b", in: animation).onTapGesture {
                                withAnimation {
                                    selectedItem = "1"
                                    selectedItemID = "b"
                                }
                            }
                        }
                        VStack(spacing:0) {
                            Image("1").resizable().matchedGeometryEffect(id: "c", in: animation).onTapGesture {
                                withAnimation {
                                    selectedItem = "1"
                                    selectedItemID = "c"
                                }
                            }
                            Image("1").resizable().matchedGeometryEffect(id: "d", in: animation).onTapGesture {
                                withAnimation {
                                    selectedItem = "1"
                                    selectedItemID = "d"
                                }
                            }
                        }
                    }
                } else {
                    Image("1").resizable().matchedGeometryEffect(id: selectedItemID!, in: animation).onTapGesture {
                        withAnimation {
                            selectedItem = nil
                            selectedItemID = nil
                        }
                    }
                }
                HStack {
                    VStack(alignment: .leading) {
                        AmbulanceSelectorButton().onTapGesture {
                            withAnimation {
                                viewModel.currentAmbulance = nil
                            }
                        }
                        if let amb = viewModel.currentAmbulance {
                            SmallMapView(latitude: Double(amb.latitude), longitude: Double(amb.longitude))
                        }
                        Spacer()
                        MicroPhoneButton()
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        VitalsView().frame(width: 375, height: 200, alignment: .center).padding([.top, .bottom]).background(Color.white).cornerRadius(25.0)
                        Spacer()
                        FileSelector(dataSource: RealtimeDataSource())
                    }
                }.padding().padding([.top])
            }
        }.ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewLayout(.fixed(width: 1194, height: 834)).environmentObject(MainViewModel())
    }
}
