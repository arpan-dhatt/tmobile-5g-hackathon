//
//  FileEditor.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI
import PencilKit

struct FileEditor: View {
    var file: TransferredFile
    var body: some View {
        Writer(image: file.images[0]).frame(width: 600, height: 600, alignment: .center)
    }
}

struct FileEditor_Previews: PreviewProvider {
    static var previews: some View {
        FileEditor(file: .init(time_ms: 100, type: "EKG", images: [UIImage(named: "1")!]))
    }
}

struct Writer: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    var image: UIImage

    var body: some View {
        VStack {
            Button("Clear") {
                canvasView.drawing = PKDrawing()
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
