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
    
    func add(note: Note, at index: Int32? = nil ) {
        let oldNotes = self.notes.sorted()
        
        if let index = index {
            note.order = Int32(index + 1)
            
            let changeNotes = oldNotes.filter { $0.order > index }
            for note in changeNotes {
                note.order += 1
            }
        } else {
            note.order = (oldNotes.last?.order ?? 0 ) + 1
        }
        
        note.folder = self 
//        self.notes_?.adding(note)

    }
    
    func add(subfolder: Folder, at index: Int32? = nil) {
        let oldFolders = self.children.sorted()
        
        if let index = index {
            subfolder.order = index + 1
            let changeFolders = oldFolders.filter({ $0.order >= index })
            for folder  in changeFolders {
                folder.order += 1
            }
        } else {
            subfolder.order = (oldFolders.last?.order ?? 0 ) + 1
        }
        subfolder.parent = self 
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
    
    
    //MARK: - preview helpers
    static func nestedFolder(context: NSManagedObjectContext) -> Folder {
        let parent = Folder(name: "parent", context: context)
        let child1 = Folder(name: "child1", context: context)
        let child2 = Folder(name: "child2", context: context)
        let child3 = Folder(name: "child3", context: context)
        
//        child1.parent = parent
        //TODO: add child
        parent.add(subfolder: child1)
        parent.add(subfolder: child2)
        child2.add(subfolder: child3)
        return parent
    }
    
}

//MARK: - comparable
extension Folder: Comparable {
    public static func < (lhs: Folder, rhs: Folder) -> Bool {
        lhs.order < rhs.order
    }
    
    
}

//MARK: - define my string properties
 
struct FolderProperties {
    static let uuid = "uuid_"
    static let creationDate = "creationDate_"
    static let name = "name_"
    static let order = "order"
    
    static let notes = "notes_"
    static let parent = "parent"
    static let children = "children_"
    
}

