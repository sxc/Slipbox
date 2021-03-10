//
//  Note+helper.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import Foundation
import CoreData

extension Note {
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.creationDate = Date()
        
        try? context.save()
    }
    
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        request.predicate = predicate
        return request
    }
}
