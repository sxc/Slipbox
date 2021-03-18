//
//  ContentView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import SwiftUI

struct ContentView: View {
    
    
    @EnvironmentObject var nav: NavigationStateManager
    
    var body: some View {
        HSplitView {
            
            FolderListView()
                .frame(minWidth: 100, idealWidth: 150, maxWidth: 300)
            
            NoteListView(folder: nav.selectedFolder, selectedNote: $nav.selectedNote)
                .frame(minWidth: 100, idealWidth: 150, maxWidth: 300)
            
            
            
            if nav.selectedNote != nil {
                NoteView(note: nav.selectedNote!)
            } else {
                Text("please select a note")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        } .frame(maxWidth: .infinity, maxHeight: .infinity)

        
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//            .environmentObject(NavigationStateManager)
//    }
//}
