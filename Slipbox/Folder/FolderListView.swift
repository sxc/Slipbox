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
    
    @FetchRequest(fetchRequest: Folder.fetch(.all)) var folders: FetchedResults<Folder>
    
//    @Binding var selectedFolder: Folder?
    
    @EnvironmentObject var nav: NavigationStateManager
    
    @State private var makeNewFolder: Bool = false
    
  
    var body: some View {
        VStack {
            HStack {
                Text("Folder")
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    makeNewFolder = true
                }, label: {
                    Image(systemName: "plus")
                })
     
            }.padding([.horizontal, .top])
            
            
            
            List{
            ForEach(folders) { folder in
                
                RecursiveFolderView(folder: folder)

          
                
            }.listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
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
        FolderListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(NavigationStateManager())
            .frame(width: 200)
        
    }
    
}

