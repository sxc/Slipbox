//
//  NotesTests.swift
//  SlipboxTests
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import XCTest
@testable import Slipbox


class NotesTests: XCTestCase {

    var controller: PersistenceController!
    
    override func setUp() {
        super.setUp()
        
        controller = PersistenceController.empty
    }
    
    override func tearDown() {
        super.tearDown()
        UnitTestHelpers.deletesAll(container: controller.container)
    }
    
    func testAddNote() {
        let context = controller.container.viewContext
        let title = "new"
        let note = Note(title: title, context: context)
        
        XCTAssertTrue(note.title == title)
        XCTAssertNotNil(note.creationDate, "note should have a date")
    }
    
    
    func testUpdateNote() {
        let context = controller.container.viewContext
        let note = Note(title: "old", context: context)
        note.title = "new"
        
        
        XCTAssertTrue(note.title == "new")
        XCTAssertFalse(note.title == "old", "note's title not corretcly updated")
    }
    
    func testFetchNotes() {
        let context = controller.container.viewContext
        
        let note = Note(title: "fetch me", context: context)
        
        let request = Note.fetch(NSPredicate.all)
        
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count > 0, "need to have at least one note")
        
        XCTAssertTrue(fetchedNotes?.first == note, "new note ahould be fetched")
    }
    
    func testSave() {
        // asyncchronous testing
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: controller.container.viewContext) { _ in
            return true
        }
        
        controller.container.viewContext.perform {
            let note = Note(title: "title", context: self.controller.container.viewContext)
            
            XCTAssertNotNil(note, "note should be there")
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            XCTAssertNil(error, "saving not complete")
        }
    }
    
    func testDeleteNote() {
        let context = controller.container.viewContext
        let note = Note(title: "note to delete", context: context)
        
        Note.delete(note: note)
        
        let request = Note.fetch(NSPredicate.all)
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count == 0, "core data fetch should be empty")
        
        XCTAssertFalse(fetchedNotes!.contains(note), "fetched notes should not contain my deleted note")
        
    }
    
    
}
