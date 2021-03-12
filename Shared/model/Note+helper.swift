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
    
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: NoteProperties.creationDate)
        setPrimitiveValue(UUID(), forKey: NoteProperties.uuid)
    }
    
    
    
    var title: String {
        get { return title_ ?? ""}
        set { title_ = newValue }
        }
    
    var creationDate: Date {
        get {
            return creationDate_ ?? Date()
        }
        
        set {
            creationDate_ = newValue
        }
    }
    
    var bodyText: String {
        get {
            return bodyText_ ?? ""
        }
        
        set {
            bodyText_ = newValue
        }
    }
    
    var formattedText: NSAttributedString {
        get {
            if let data = formattedText_ as NSData? {
                return data.toAttributedStrin()
            } else {
                return NSAttributedString(string: "")
            }
        }
        
        set {
            bodyText_ = newValue.string
            formattedText_ = newValue.toNSData() as Data?
        }
            
    }
    
    
    var uuid: UUID {
        get {
            return uuid_ ?? UUID()
        }
        
        set {
            uuid_ = newValue
        }
    }
    
    
    var status: Status {
        get { return Status(rawValue: status_ ?? "") ?? Status.draft }
        set { status_ = newValue.rawValue }
    }
    
    
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: NoteProperties.creationDate, ascending: false)]
        
        request.predicate = predicate
        return request
    }
    
    static func delete(note: Note) {
        //TODO
        if let context = note.managedObjectContext {
        
        context.delete(note)
        }
    }
    
    //MARK: - preview helper properties
    
    static let defaultText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    
}


//MARK: - property names as strings

struct NoteProperties {
    static let creationDate = "creationDate_"
    static let title = "title_"
    static let bodyText = "bodyText_"
    static let formattedText = "formattedText_"
    static let status = "status_"
    static let uuid = "uuid_"
    static let img = "img"
    
    
}
