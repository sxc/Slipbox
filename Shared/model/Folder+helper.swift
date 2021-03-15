//
//  Folder+helper.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/15.
//

import Foundation
import CoreData

extension Folder {
    
    // TODO: init
      
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
    }
    
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: NoteProperties.creationDate)
        setPrimitiveValue(UUID(), forKey: NoteProperties.uuid)
    }

    
    var uuid: UUID {
        get { return uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
    var creationDate: Date {
        get {
            return creationDate_ ?? Date()
        }
        
        set {
            creationDate_ = newValue
        }
    }
    
    
    var name: String {
        get { return name_ ?? ""}
        set {
            name_ = newValue
        }
    }
    
    // TODO: optional
    var notes: Set<Note> {
        get { notes_ as? Set<Note> ?? [] }
        set { notes_ = newValue as NSSet }
    }
    
    // TODO: fetch reques
    
    // TODO: delete
    
    
}

//  TODO: define my string properties
