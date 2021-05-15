//
//  AmbulanceSelectorButton.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI

struct AmbulanceSelectorButton: View {
    @EnvironmentObject var viewModel: MainViewModel
    var body: some View {
        HStack{
            Spacer()
            Text(viewModel.currentAmbulance?.name ?? "")
            Spacer()
        }.frame(width: 200, height: 60).background(Color.white).cornerRadius(25.0)
    }
}

struct AmbulanceSelectorButton_Previews: PreviewProvider {
    static var previews: some View {
        AmbulanceSelectorButton().environmentObject(MainViewModel())
    }
}
