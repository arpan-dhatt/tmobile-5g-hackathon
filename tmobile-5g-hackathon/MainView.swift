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
    private var streamers = [MJPEGStreamer]()
    @State var selectedStreamer: MJPEGStreamer?
    @State var selectedStreamerIndex: Int?
    
    var body: some View {
        ZStack {
            if viewModel.currentAmbulance == nil {
                AmbulanceSelectorView()
            }
            else {
                if selectedStreamer == nil && selectedStreamerIndex != nil{
                    if streamers.count == 4 {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                MJPEGView(streamers[0]).aspectRatio(contentMode: .fill).matchedGeometryEffect(id: "\(0)", in: animation).onTapGesture {
                                    withAnimation {
                                        selectedStreamer = streamers[0]
                                        selectedStreamerIndex = 0
                                    }
                                }
                                MJPEGView(streamers[1]).aspectRatio(contentMode: .fill).matchedGeometryEffect(id: "\(1)", in: animation).onTapGesture {
                                    withAnimation {
                                        selectedStreamer = streamers[1]
                                        selectedStreamerIndex = 1
                                    }
                                }
                            }
                            VStack(spacing: 0) {
                                MJPEGView(streamers[2]).aspectRatio(contentMode: .fill).matchedGeometryEffect(id: "\(2)", in: animation).onTapGesture {
                                    withAnimation {
                                        selectedStreamer = streamers[2]
                                        selectedStreamerIndex = 2
                                    }
                                }
                                MJPEGView(streamers[3]).aspectRatio(contentMode: .fill).matchedGeometryEffect(id: "\(3)", in: animation).onTapGesture {
                                    withAnimation {
                                        selectedStreamer = streamers[3]
                                        selectedStreamerIndex = 3
                                    }
                                }
                            }
                        }
                    }
                } else {
                    MJPEGView(selectedStreamer!).aspectRatio(contentMode: .fill).matchedGeometryEffect(id: "\(selectedStreamerIndex)", in: animation).onTapGesture {
                        withAnimation {
                            selectedStreamer = nil
                            selectedStreamerIndex = nil
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
