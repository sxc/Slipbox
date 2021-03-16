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
        
        let request = Folder.topFolderFetch()
        let result = try? context.fetch(request)
        
        let maxFolder = result?.max(by: { $0.order < $1.order })
        self.order = (maxFolder?.order ?? 0) + 1
    
        
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
    
    // TODO: optional notes
    var notes: Set<Note> {
        get { notes_ as? Set<Note> ?? [] }
//        set { notes_ = newValue as NSSet }
    }
    
    var children: Set<Folder> {
        get { children_ as? Set<Folder> ?? [] }
        set { children_ = newValue as NSSet  }
    }
    
    func add(note: Note, at index: Int? = nil ) {
        let oldNotes = self.notes.sorted()
        
        if let index = index {
            note.order = Int32(index)
            
            let changeNotes = oldNotes.filter { $0.order >= index }
            for note in changeNotes {
                note.order += 1
            }
        } else {
            note.order = (oldNotes.last?.order ?? 0 ) + 1
        }
        
        note.folder = self 
//        self.notes_?.adding(note)

    }
    //MARK: - fetch reques
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Folder> {
        let request = NSFetchRequest<Folder>(entityName: "Folder")
        request.sortDescriptors = [NSSortDescriptor(key: FolderProperties.creationDate, ascending: false)]
        
        request.predicate = predicate
        return request
    }
    
    static func topFolderFetch() -> NSFetchRequest<Folder> {
        let request = NSFetchRequest<Folder>(entityName: "Folder")
        request.sortDescriptors = [NSSortDescriptor(key: FolderProperties.creationDate, ascending: false)]
        
        let format = FolderProperties.parent + " = nil"
        request.predicate = NSPredicate(format: format)
        
        return request
    }
    
    // TODO: delete
    
    static func delete(_ folder: Folder) {
        if let context = folder.managedObjectContext {
            context.delete(folder)
        }
    }
    
    
}

//MARK: - define my string properties
 
struct FolderProperties {
    static let uuid = "uuid_"
    static let creationDate = "creationDate_"
    static let name = "name"
    static let order = "order"
    
    static let notes = "notes_"
    static let parent = "parent"
    static let children = "children_"
    
}

