//
//  AmbulanceSelectorView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct AmbulanceSelectorView: View {
    @ObservedObject var ambulanceData: AmbulanceListDataSource
    
    var body: some View {
        ZStack{
            VStack{
                Text("Select Ambulance")
                Divider()
                
                ScrollView(.vertical, showsIndicators: false){
                    HStack{
                        VStack{
                            ForEach(0..<ambulanceData.items.count){ index in
                                if(index%2 == 0){
                                AmbulanceInfoCardView(name: ambulanceData.items[index].name, status: ambulanceData.items[index].going_to, estimatedArrival: ambulanceData.items[index].arriving_in, availibility: ambulanceData.items[index].going_to)
                                }
                            }
                        }
                        VStack{
                            ForEach(0..<ambulanceData.items.count){ index in
                                if(index%2 == 1){
                                AmbulanceInfoCardView(name: ambulanceData.items[index].name, status: ambulanceData.items[index].going_to, estimatedArrival: ambulanceData.items[index].arriving_in, availibility: ambulanceData.items[index].going_to)
                                }
                            }
                        }
                    }
                }
            }.padding()
            }.onAppear{
                ambulanceData.loadData()
        }
    }
}

struct AmbulanceInfoCardView: View {
    var name: String
    var status: String
    var estimatedArrival: String
    var availibility: String
    var selection = { (selection: String) -> String in
        return selection
    }
    var selected = { (selected: DarwinBoolean) -> Color in
        if selected == true {
            return Color.green
        }
        return Color.white
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Ambulance"+name)
                Spacer()
                if status == "inactive"{
                    Circle().fill(Color.red).frame(width: 25)
                }
                else if status == "trauma center"{
                    Circle().fill(Color.green).frame(width: 25)
                }
                else{
                    Circle().fill(Color.yellow).frame(width: 25)
                }
            }
            Text("En Route To"+status)
            Text("Arriving In"+estimatedArrival)
        }.padding().cornerRadius(10.0).overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 2)).padding()
    }
}

struct AmbulanceSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        AmbulanceSelectorView(ambulanceData: AmbulanceListDataSource())
    }
}
