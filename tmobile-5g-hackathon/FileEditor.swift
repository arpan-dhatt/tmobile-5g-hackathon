//
//  FileEditor.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI

struct FileEditor: View {
    var file: TransferredFile
    var body: some View {
        Text(file.type)
    }
}

struct FileEditor_Previews: PreviewProvider {
    static var previews: some View {
        FileEditor(file: .init(time_ms: 100, type: "EKG", images: [UIImage(named: "1")!]))
    }
}
