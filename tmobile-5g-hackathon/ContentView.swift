//
//  ContentView.swift
//  tmobile-5g-hackathon
//
//  Created by Arpan Dhatt on 5/13/21.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        Writer(image: UIImage(named: "biden.jpg")!).frame(width:300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 1194, height: 834))
    }
}

struct Writer: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    var image: UIImage

    var body: some View {
        VStack(spacing: 10) {
            Button("Clear") {
                canvasView.drawing = PKDrawing()
            }
            Button("Undo") {
                undoManager?.undo()
            }
            Button("Redo") {
                undoManager?.redo()
            }
            MyCanvas(canvasView: $canvasView, toolPicker: $toolPicker, image: image)
        }
    }
}

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    var image: UIImage?

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        canvasView.maximumZoomScale = 5
        canvasView.minimumZoomScale = 1
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        if image != nil {
            let imageView = UIImageView(image: image)
            let contentView = canvasView.subviews[0]
            contentView.addSubview(imageView)
            contentView.sendSubviewToBack(imageView)
        }
        
        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}

struct MyPicker: UIViewRepresentable{
    
    
    @Binding var toolPickerView: PKToolPicker
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        toolPickerView.setVisible(true, forFirstResponder: canvasView)
        toolPickerView.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}
