//
//  FolderRow.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/16.
//

import SwiftUI

struct FolderRow: View {
    
    let name: String
    let isSelected: Bool
    
    let selectedColor: Color = Color("selectedColor")
    let unselectedColor: Color = Color("unselectedColor")
  
    
    var body: some View {
        Text(name)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(isSelected ? selectedColor : unselectedColor))
    }
}


struct FolderRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FolderRow(name: "folder", isSelected: false)
            FolderRow(name: "selected folder", isSelected: true)
        }
    }
}
