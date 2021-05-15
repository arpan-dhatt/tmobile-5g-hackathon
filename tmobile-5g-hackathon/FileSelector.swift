//
//  FileSelector.swift
//  tmobile-5g-hackathon
//
//  Created by user175936 on 5/14/21.
//

import SwiftUI

struct FileSelector: View {
    @EnvironmentObject var viewModel: MainViewModel
    @ObservedObject var dataSource: RealtimeDataSource
    @State var expanded = true
    @Namespace var animation
    @State var showingSheet = false
    @State var selectedFile: TransferredFile = .init(time_ms: 100, type: "EG", images: [UIImage(named: "1")!])
    
    var body: some View {
        if expanded {
            HStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                    ForEach(dataSource.transferred_files, id: \.id){file in
                        Image(uiImage: file.images[0]).resizable().scaledToFill().cornerRadius(25.0).onTapGesture{
                            selectedFile = file
                            withAnimation{
                                showingSheet.toggle()
                            }
                        }
                    }
                    }
                }.matchedGeometryEffect(id: "pictures", in: animation)
                Image(systemName: "chevron.right").font(.system(size: 50)).padding().frame(minHeight: 125).background(Color.white).cornerRadius(25.0).onTapGesture {
                    withAnimation{
                        expanded.toggle()
                    }
                }.matchedGeometryEffect(id: "arrow", in: animation)
                
            }.padding().frame(maxWidth: 450, maxHeight:150).background(Color.white).cornerRadius(25.0).padding().sheet(isPresented: $showingSheet){
                FileEditor(file: selectedFile)
            }
        }
        else {
            HStack{
                EmptyView().matchedGeometryEffect(id: "pictures", in: animation)
                Spacer()
                Image(systemName: "chevron.left").font(.system(size: 50)).padding().frame(minHeight: 125).background(Color.white).cornerRadius(25.0).onTapGesture {
                    withAnimation{
                        expanded.toggle()
                    }
                }.matchedGeometryEffect(id: "arrow", in: animation)
            }.frame(maxWidth: 450, maxHeight:150)
        }
    }
}

struct FileSelector_Previews: PreviewProvider {
    static var previews: some View {
        FileSelector(dataSource: RealtimeDataSource()).environmentObject(MainViewModel())
    }
}
