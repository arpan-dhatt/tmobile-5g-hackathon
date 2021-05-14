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
//    @GestureState var isDetectingLongPress = false
//    @State var status = "none"
//
//    var longPress: some Gesture {
//        LongPressGesture().updating($isDetectingLongPress){currentState, gestureState,transaction in
//            //microphone.startStreaming()
//            gestureState = currentState
//            transaction.animation = Animation.easeIn(duration: 2.0)
//            status = "active"
//        }.onEnded{ finished in
//            //microphone.finishStreaming(success: true)
//            status = "ended"
//        }
//    }
    
    var body: some View {
        ZStack{
            Circle().fill(Color.red).frame(width: 100, height: 100, alignment: .center)
            HStack{
                
                    Image(systemName: "waveform").frame(width: 75, height: 75)
                
                
                    Image(systemName: "record.circle").frame(width: 75, height: 75)
                
            }
        }
    }
}

struct MicroPhoneButton_Previews: PreviewProvider {
    static var previews: some View {
        MicroPhoneButton().environmentObject(MainViewModel())
    }
}
