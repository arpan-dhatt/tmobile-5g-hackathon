//
//  AmbulanceSelectorView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI

struct AmbulanceSelectorView: View {
    @ObservedObject var ambulanceData = AmbulanceListDataSource()
    @State var text: String = ""
    
    var body: some View {
        ZStack{
            
            VStack{
                Text("Select Ambulance").font(.largeTitle).bold().padding(.vertical,50)
                Divider()
                
                ScrollView(.vertical, showsIndicators: false){
                    HStack{
                        VStack{
                            ForEach(Array(zip(ambulanceData.items.indices, ambulanceData.items)), id: \.0){ (index, item) in
                                if(index%2 == 0){
                                    AmbulanceInfoCardView(name: ambulanceData.items[index].name, status: item.going_to, estimatedArrival: item.arriving_in, availibility: item.going_to)
                                }
                            }
                        }
                        VStack{
                            ForEach(Array(zip(ambulanceData.items.indices, ambulanceData.items)), id: \.0){ (index, item) in
                                if(index%2 == 1){
                                    AmbulanceInfoCardView(name: ambulanceData.items[index].name, status: item.going_to, estimatedArrival: item.arriving_in, availibility: item.going_to)
                                }
                            }
                        }
                    }
                }
            }.padding().background(Color.pink).cornerRadius(25.0).padding(50)
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
        VStack(alignment: .leading){
            HStack{
                Text("Ambulance: "+name).font(.headline)
                Spacer()
                if status == "inactive"{
                    Circle().fill(Color.red).frame(width: 25, height: 25).overlay(Circle().stroke(Color.black, lineWidth: 1)).padding()
                }
                else if status == "trauma center"{
                    Circle().fill(Color.green).frame(width: 25, height: 25).overlay(Circle().stroke(Color.black, lineWidth: 1)).padding()
                }
                else{
                    Circle().fill(Color.yellow).frame(width: 25, height: 25).overlay(Circle().stroke(Color.black, lineWidth: 1)).padding()
                }
            }.padding(.bottom, -15)
            
            
                
            
            if status == "trauma center" {
                Divider().background(Color.green)
            }
            else if status == "inactive" {
                Divider().background(Color.red)
            }
            else {
                Divider().background(Color.yellow)
            }
            
            Text("En Route To: "+status).font(.headline).padding(.top, 10)
            Text("Arriving In: "+estimatedArrival).font(.headline)
        }.padding().padding(.horizontal).cornerRadius(10.0).frame(maxHeight: 250).overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 1)).padding()
    }
}

struct AmbulanceSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        AmbulanceSelectorView()
    }
}
