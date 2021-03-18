//
//  RecursiveFolderView.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/16.
//

import SwiftUI

struct RecursiveFolderView: View {
    
    @EnvironmentObject var nav: NavigationStateManager
    
    @ObservedObject var folder: Folder
    
//    let selectedFolder: Folder?
    
    @State private var showSubfolders: Bool = false
    var body: some View {
        
        Group {
                HStack {
                    Text("\(folder.order)")
                        .bold()
                    
                    FolderRow(folder: folder)
                    
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
                    RecursiveFolderView(folder: child)
                        .padding(.leading)
                    
                }).listRowInsets(.init(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
        }
    }
}

//struct RecursiveFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        List {
//            RecursiveFolderView(folder: Folder.nestedFolder(context: PersistenceController.preview.container.viewContext))
//    }
//        .frame(width: 200)
//        .environmentObject(NavigationStateManager())
//    }
//}

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
