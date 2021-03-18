//
//  ContentView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var selectedNote: Note? = nil
    @State private var selectedFolder: Folder? = nil 
    
    var body: some View {
        HSplitView {
            
            FolderListView(selectedFolder: $selectedFolder)
                .frame(minWidth: 100, idealWidth: 150, maxWidth: 300)
            
            NoteListView(folder: selectedFolder, selectedNote: $selectedNote)
                .frame(minWidth: 100, idealWidth: 150, maxWidth: 300)
            
            
            
            if selectedNote != nil {
                NoteView(note: selectedNote!)
            } else {
                Text("please select a note")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        } .frame(maxWidth: .infinity, maxHeight: .infinity)

        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
