//
//  NoteView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/11.
//

import SwiftUI

struct NoteView: View {
    
    @ObservedObject var note: Note
    
    var body: some View {
        VStack {
            TextField("notes title", text: $note.title)
            
            TextEditor(text: $note.bodyText)
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
            .frame(width: 400, height: 400)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/400.0/*@END_MENU_TOKEN@*/))
    }
}
