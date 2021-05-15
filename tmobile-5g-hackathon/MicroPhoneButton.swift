//
//  MicroPhoneButton.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI

struct MicroPhoneButton: View {
    @EnvironmentObject var viewModel: MainViewModel
    @ObservedObject var microphone = Microphone()
    @State var pressed = false
    @State var status = "none"
    
    var body: some View {
        ZStack{
            Circle().fill(pressed ? Color.red : Color.gray).frame(width: 100, height: 100, alignment: .center).scaleEffect(pressed ? 1.2 : 1.0)
            HStack{
                if pressed {
                    Image(systemName: "waveform").font(Font.system(size: 60))
                }
                else{
                    Image(systemName: "record.circle").font(Font.system(size: 40))
                }
                
            }
        }.gesture(DragGesture(minimumDistance: 0).onChanged({ _ in
            if status != "active" {
                microphone.startStreaming()
                withAnimation {
                    pressed = true
                }
                status = "active"
            }
        }).onEnded({ _ in
            microphone.finishStreaming(success: true)
            withAnimation {
                pressed = false
            }
            status = "ended"
        }))
    }
}

struct MicroPhoneButton_Previews: PreviewProvider {
    static var previews: some View {
        MicroPhoneButton().environmentObject(MainViewModel())
    }
}
