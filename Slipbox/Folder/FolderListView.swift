//
//  FolderListView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/15.
//

import SwiftUI
import CoreData

struct FolderListView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @FetchRequest(fetchRequest: Folder.fetch(.all)) var folder: FetchedResults<Folder>
    
    @Binding var selectedFolder: Folder?
    
    @State private var makeNewFolder: Bool = false
    
  
    var body: some View {
        VStack {
            HStack {
                Text("Folder")
                    .font(.title)
                
                Spacer()
                
                Button(action: {
//                    let newFolder = Folder(name: "new", context: context)
                    makeNewFolder = true
                }, label: {
                    Image(systemName: "plus")
                })
     
            }.padding([.horizontal, .top])
            
            List(folder) { folder in
                FolderRow(name: folder.name, isSelected: selectedFolder == folder)
                    .onTapGesture {
                        selectedFolder = folder
                    }
                
            }
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: $makeNewFolder, content: {
            FolderEditorView()
                .environment(\.managedObjectContext, context)
        })
        
    }
}

struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(selectedFolder: .constant(nil))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

