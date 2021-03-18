//
//  FolderRow.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/16.
//

import SwiftUI

struct FolderRow: View {
    
    @EnvironmentObject var nav: NavigationStateManager
//    @ObservedObject var folder: Folder
    let folder: Folder
    
    let selectedColor: Color = Color("selectedColor")
    let unselectedColor: Color = Color("unselectedColor")
  
    @State private var showDelete = false
    @State private var makeNewFolderStatus: FolderEditorStatus? = nil 
    
    var body: some View {
        Text(folder.name)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(nav.selectedFolder == folder ? selectedColor : unselectedColor))
        
            .onTapGesture {
                nav.selectedFolder = folder
            }
        
            .contextMenu(ContextMenu(menuItems: {
                Text("Rename Folder")
                
                Divider()
                
                Button(action: {
                    self.makeNewFolderStatus = .addFolder
                }, label: {
                    Text("Add Folder")
                })
                
                Button(action: {
                    self.makeNewFolderStatus = .addAsSubFolder
                }, label: {
                    Text("Add Subfolder")
                })
                
                Divider()
                
                //TODO: delete alert
                
                Button(action: {

                    showDelete.toggle()

                }, label: {
                    Text("Delete")
                })
            }))
        
        
        //MARK: - presentations
            .alert(isPresented: $showDelete, content: {
                Alert(title: Text("Do you really want to delete this folder?"),
                                  message: nil,
                                  primaryButton: Alert.Button.cancel(),
                                  secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
                                    if folder == nav.selectedFolder {
                                        nav.selectedFolder = nil
                                    }
                                    Folder.delete(folder)
                                  }))
            })
        
            .sheet(item: $makeNewFolderStatus) { status in
                FolderEditorView(editorStatus: status, contextFolder: folder)
                
            }
        
        
            
    }
}


//struct FolderRow_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            FolderRow(name: "folder", isSelected: false)
//            FolderRow(name: "selected folder", isSelected: true)
//        }
//    }
//}
