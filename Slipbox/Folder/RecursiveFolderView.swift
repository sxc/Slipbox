//
//  RecursiveFolderView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/16.
//

import SwiftUI

struct RecursiveFolderView: View {
    
    @ObservedObject var folder: Folder
    let selectedFolder: Folder?
    @State private var showSubfolders: Bool = true
    var body: some View {
        
        Group {
                HStack {
//                    Text("\(folder.order)")
//                        .bold()
                    
                    FolderRow(name: folder.name, isSelected: selectedFolder == folder)
                    
                    Spacer()
                    Button(action: {
                        withAnimation { showSubfolders.toggle() }
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                            .rotationEffect(.init(degrees: showSubfolders ? 90: 0))
                    }).buttonStyle(PlainButtonStyle())
                }
        
            if showSubfolders {
            
            
            ForEach(folder.children.sorted(), content: { child in
                RecursiveFolderView(folder: child, selectedFolder: selectedFolder)
                    .padding(.leading)
                
//                FolderRow(name: child.name, isSelected: selectedFolder == folder)
            }).listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
            }
    }
}

struct RecursiveFolderView_Previews: PreviewProvider {
    static var previews: some View {
        List {
        RecursiveFolderView(folder: Folder.nestedFolder(context: PersistenceController.preview.container.viewContext), selectedFolder: nil)
    }
        .frame(width: 200)
    }
}

//struct RecursiveFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        List {
//            RecursiveFolderView(folder: Folder.nestedFolder(context: PersistenceController.preview.container.viewContext), selectedFolder: nil)
//        }
//        .frame(width: 200)
////        .environmentObject(NavigationStateManager())
//
//
//    }
//}
