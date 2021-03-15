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
        
//        folder.notes_
        
        XCTAssertTrue(folder.notes.count == 0 , "created a folder with no notes")
    }
    

}
