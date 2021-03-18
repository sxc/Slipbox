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
    
    @EnvironmentObject var nav: NavigationStateManager
    
    //NEW parent folder
    let editorStatus: FolderEditorStatus
    let contextFolder: Folder?
    
    var body: some View {
        VStack {
            Text("Create new Folder")
                .font(.title)
            
            TextField("name", text: $folderName) { _ in
                
            } onCommit: {
                addFolder()
            }
            

            
            HStack {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
                
                Button(action: {
                    addFolder()

                }, label: {
                    Text("Create")
                })
            }
            
        }.padding()
    }
    
    func addFolder() {
        let folder = Folder(name: folderName, context: context)
        if editorStatus == .addAsSubFolder {
            contextFolder?.add(subfolder: folder)
        } else if let beforeFolder = self.contextFolder,
                 let parent = beforeFolder.parent {
            //NEW add the right index
            parent.add(subfolder: folder, at: beforeFolder.order)
        }
        
        nav.selectedFolder = folder
        presentation.wrappedValue.dismiss()
    }
    
}

//struct FolderEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderEditorView()
//    }
//}


//MARK: - status helper
enum FolderEditorStatus: String, Identifiable {
    
    case editContextFolder = "editContextFolder"
    case addFolder = "addFolder"
    case addAsSubFolder = "addAsSubFolder"
    
    var id: String {
        self.rawValue
    }
    

    
    func newFolder() -> Bool {
        switch self {
        case .addAsSubFolder, .addFolder:
            return true
        case .editContextFolder:
            return false
        }
    }
}
