//
//  FolderRow.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/16.
//

import SwiftUI

struct FolderRow: View {
    
    @EnvironmentObject var nav: NavigationStateManager
    
    let folder: Folder
    
    let selectedColor: Color = Color("selectedColor")
    let unselectedColor: Color = Color("unselectedColor")
  
    
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
                Text("Add Subfolder")
                Text("Add Folder")
                Divider()
                
                Button(action: {
                    if folder == nav.selectedFolder {
                        nav.selectedFolder = nil
                    }
                    Folder.delete(folder)
                }, label: {
                    Text("Delete")
                })
            }))
        
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
