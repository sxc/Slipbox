//
//  NavigationStateManager.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/18.
//

import Foundation
import Combine

class NavigationStateManager: ObservableObject {
    
    @Published var selectedNote: Note? = nil
    @Published var selectedFolder: Folder? = nil
}
