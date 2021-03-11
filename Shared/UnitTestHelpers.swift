//
//  UnitTestHelpers.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/11.
//

import Foundation
import CoreData

struct UnitTestHelpers {
    
    static func deletesAllNotes(container: NSPersistentCloudKitContainer) {
        
        let context = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        try? container.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }
}
