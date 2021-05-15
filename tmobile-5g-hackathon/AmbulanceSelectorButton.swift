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
            Text(viewModel.currentAmbulance!.name)
            Spacer()
        }.frame(minWidth: 200, maxHeight: 100).background(Color.red).padding()
    }
}

struct AmbulanceSelectorButton_Previews: PreviewProvider {
    static var previews: some View {
        AmbulanceSelectorButton().environmentObject(MainViewModel())
    }
}
