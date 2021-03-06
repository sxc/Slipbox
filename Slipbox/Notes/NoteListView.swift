//
//  NoteListView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/11.
//

import SwiftUI

struct NoteListView: View {
    
    init(folder: Folder?, selectedNote: Binding<Note?>) {
        self._selectedNote = selectedNote
        
        var predicate = NSPredicate.none
        if let folder = folder {
            predicate = NSPredicate(format: "%K == %@ ", NoteProperties.folder, folder)
        }
        self._notes = FetchRequest(fetchRequest: Note.fetch(predicate))
        self.folder = folder
    }
    
    let folder: Folder?
    
    @Binding var selectedNote: Note?
    
    @State private var showDeleteAlert: Bool = false
    @State private var shouldDeleteNote: Note? = nil
    
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes:
        FetchedResults<Note>
    
   
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Notes")
                    .font(.title)
                    Spacer()
                Button(action: {
                    let note = Note(title: "new note", context: context)
                    selectedNote = note
                    folder?.add(note: note, at: selectedNote?.order)
                    
                }, label: {
                    Image(systemName: "plus")
                }).disabled(folder == nil )
            }.padding([.top, .horizontal])
            
            List {
                ForEach(notes) {  note in
                    HStack {
                        Text("\(note.order)")
                            .bold()
                        
                        NoteRow(title: note.title, bodyText: note.bodyText, creationDate: note.creationDate, isSelected: note == selectedNote)
                    }
                                                .onTapGesture {
                                                    selectedNote = note
                                                }
                        // menu
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
//                                self.showDeleteAlert = true
                                
                                self.shouldDeleteNote = note
                                
                                
//                                if selectedNote == note {
//                                    selectedNote = nil
//                                }
//                                Note.delete(note: note)
                            }, label: {
                                Text("Delete")
                            })
                        }))
                }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
//            .alert(isPresented: $showDeleteAlert, content: {
//                deleteAlert()
//            })
            
            .alert(item: $shouldDeleteNote) { noteToDelete in
                deleteAlert(note: noteToDelete)
                
            }
            
            
        }
 
    }
    
    func deleteAlert(note: Note) -> Alert {
        Alert(title: Text("Are you sure to delete this note?"),
              message: nil,
              primaryButton: Alert.Button.cancel(),
              secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
                if selectedNote == note {
                                                   selectedNote = nil
                                               }
                                               Note.delete(note: note)
        }))
    }
    
}




struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        let request = Note.fetch(NSPredicate.all)
        let fetchedNotes = try? context.fetch(request)
        
        let folder = Folder(context: context)
        for note in fetchedNotes! {
            folder.add(note: note)
        }
        
        
        return NoteListView(folder: folder, selectedNote: .constant(fetchedNotes?.first))
            .environment(\.managedObjectContext, context)
    }
}

