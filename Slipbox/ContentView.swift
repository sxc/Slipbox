//
//  ContentView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import SwiftUI

struct ContentView: View {
    
//    @Environment(\.managedObjectContext) private var context
//
//    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes:
//        FetchedResults<Note>
    
    @State private var selectedNote: Note? = nil
    
    var body: some View {
        HSplitView {
            
            NoteListView(selectedNote: $selectedNote)
            
            
            if selectedNote != nil {
                NoteView(note: selectedNote!)
            } else {
                Text("please select a note")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            
            
//            NoteView(note: <#T##Note#>)
                
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(.title)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
