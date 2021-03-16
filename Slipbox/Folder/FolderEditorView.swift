//
//  FolderEditorView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/16.
//

import SwiftUI

struct FolderEditorView: View {
    
    @State private var folderName: String = ""
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    var body: some View {
        VStack {
            Text("Create new Folder")
                .font(.title)
            TextField("name", text: $folderName)
            
            HStack {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Button(action: {
                    _ = Folder(name: folderName, context: context)
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Create")
                })
            }
        }.padding()
    }
}

struct FolderEditorView_Previews: PreviewProvider {
    static var previews: some View {
        FolderEditorView()
    }
}
