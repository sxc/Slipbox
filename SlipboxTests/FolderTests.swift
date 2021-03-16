//
//  FolderTests.swift
//  SlipboxTests
//
//  Created by Xiaochun Shen on 2021/3/15.
//

import XCTest
@testable import Slipbox

class FolderTests: XCTestCase {

    var controller: PersistenceController!
    
    var context: NSManagedObjectContext {
        return controller.container.viewContext
    }
    
    override func setUp() {
        super.setUp()
        
        controller = PersistenceController.empty
        
    }
    
    override func tearDown() {
        super.tearDown()
        // TODO: clean up
        
        
    }
    
    func testAddFolder() {
        let folder = Folder(name: "new", context: context)
        XCTAssertNotNil(folder.uuid)
        XCTAssertNotNil(folder.creationDate, "folder needs to hava a creation date.")

        XCTAssertTrue(folder.notes.count == 0 , "created a folder with no notes")
        
        
        //        folder.notes_
        
//        let notes: [Note] = folder.notes.sorted()
        
        
        
    }
    

    func testaddNoteToFolder() {
        let notesTitle = "new"
        
        let folder = Folder(name: "new", context: context)
        let note = Note(title: "add me", context: context)
        
        note.folder = folder
        
        XCTAssertTrue(note.folder?.name == notesTitle)
        XCTAssertNotNil(note.folder, "note should have been added to a folder")
        XCTAssertTrue(folder.notes.count == 1)
    }
    
    func testAddMultipleNotes() {
        let folder = Folder(name: "folder", context: context)
        let note1 = Note(title: "first", context: context)
        let note2 = Note(title: "second", context: context)
        let note3 = Note(title: "third", context: context)
        
        note1.folder = folder
        note2.folder = folder
        
//        folder.notes.sorted()
        
//        folder.notes.insert(note1)
//        folder.notes.insert(note2)
        
        folder.add(note: note1)
        folder.add(note: note2)
        folder.add(note: note3, at: 2)
        
        
//        note1.folder = nil
        XCTAssertTrue((folder.notes.count == 3))
        
//        XCTAssertTrue(note1.folder == folder)
        XCTAssertTrue(note2.folder == folder)
        
        XCTAssertTrue(folder.notes.sorted().first == note1)
        XCTAssertTrue(folder.notes.sorted().last == note2)
        
        
    }
    
    func testAddNoteAtIndex() {
        let folder = Folder(name: "folder", context: context)
        let note1 = Note(title: "first", context: context)
        let note2 = Note(title: "second", context: context)
        let note3 = Note(title: "third", context: context)
        
        folder.add(note: note1)
        folder.add(note: note2)
        folder.add(note: note3, at: 0)
        
        XCTAssertTrue(folder.notes.sorted().first == note3)
        XCTAssertTrue(folder.notes.sorted().last == note2)
        
    }
    
}
