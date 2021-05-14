//
//  AmbulanceSelectorView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct AmbulanceSelectorView: View {
    @ObservedObject var ambulanceData: AmbulanceListDataSource
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 100)), count: 2)
    }
    var body: some View {
        ZStack{
            VStack{
                Text("Select Ambulance")
                Divider()
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(ambulanceData.items, id: \._id){ item in
                        LazyVGrid(columns: items, spacing: 10){
                            AmbulanceInfoCardView(name: item.name, status: item.going_to, estimatedArrival: item.arriving_in, availibility: item.going_to)
                        }
                    }
                }
            }.padding()
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
                if status == "innactive"{
                    Circle().fill(Color.black).frame(width: 100)
                }
                else if status == "trauma center"{
                    Circle().fill(Color.green).frame(width: 100)
                }
                else{
                    Circle().fill(Color.yellow).frame(width: 100)
                }
            }
            Text("En Route To"+status)
            Text("Arriving In"+estimatedArrival)
        }.padding().cornerRadius(10.0).padding()
    }
}

struct AmbulanceSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        AmbulanceSelectorView(ambulanceData: AmbulanceListDataSource()).previewLayout(.fixed(width: 1194, height: 834))
    }
}
