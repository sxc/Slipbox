//
//  ContentView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes:
        FetchedResults<Note>
    
    var body: some View {
        VStack {
            Text("Notes")
            
            Button(action: {
                _ = Note(title: "new note", context: context)
            }, label: {
                Text("Add")
            })
            
            List(notes) { note in
                Text("title \(note.title ?? "") with date \(note.creationDate ?? Date(), formatter: itemFormatter) ")
                
            }
                
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
