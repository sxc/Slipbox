//
//  UnitTestHelpers.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/11.
//

import Foundation
import CoreData

struct UnitTestHelpers {
    
    static func deletesAllNotes(context: NSManagedObjectContext) {
        
//        UnitTestHelpers.deleteBatchRequest(entity: "Note", container: container)
        
        let request = Note.fetch(.all)
        if let result = try? context.fetch(request) {
            for r in result {
                try? context.delete(r)
            }
        }
    }
    
    static func deletesAllFolders(context: NSManagedObjectContext) {
        
//        UnitTestHelpers.deleteBatchRequest(entity: "Folder", container: container)
        
        let request = Folder.fetch(.all)
        if let result = try? context.fetch(request) {
            for r in result {
                try? context.delete(r)
            }
        }
    }
    
    static func deletesAll(container: NSPersistentCloudKitContainer) {
        
        UnitTestHelpers.deletesAllNotes(context: container.viewContext)
        UnitTestHelpers.deletesAllFolders(context: container.viewContext)
    }
    
    
    static func deleteBatchRequest(entity: String, container: NSPersistentCloudKitContainer) {
        
        let context = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        try? container.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }
    
}
