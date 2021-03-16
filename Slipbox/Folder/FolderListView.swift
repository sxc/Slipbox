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
    
    
    var body: some View {
        HStack {
            VStack {
                Text("Folder")
                Button(action: {
                    let newFolder = Folder(name: "new", context: context)
                }, label: {
                    Image(systemName: "plus")
                })
                    
                    
                    
            }
            
            List(folder) { folder in
                Text("folder \(folder.name)")
                
            }
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
