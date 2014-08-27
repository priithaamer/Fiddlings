//
//  CodeEditorKitTests.swift
//  CodeEditorKitTests
//
//  Created by Priit Haamer on 20.08.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import XCTest
import Fiddlings

class CodeEditorKitTests: XCTestCase {
    
    let editor = CodeEditorView(frame: CGRectMake(0, 0, 500, 300))
    
    override func setUp() {
        super.setUp()
        
        self.editor.string = ""
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInsertTabAddsTwoSpaces() {
        self.editor.insertTab(self.editor)
        
        XCTAssertEqual(self.editor.string, "  ", "did not add two spaces")
    }
    
    func testInsertTabAddsTwoSpacesAnywhere() {
        self.editor.insertText("Foobar")
        self.editor.setSelectedRange(NSRange(location: 3, length: 0))
        self.editor.insertTab(self.editor)
        
        XCTAssertEqual(self.editor.string, "Foo  bar", "did not have two spaces between")
    }
    
    func testInsertNewLineKeepsIndentation() {
        self.editor.insertText("  Foobar")
        self.editor.setSelectedRange(NSRange(location: 5, length: 0))
        self.editor.insertNewline(self.editor)
        
        XCTAssertEqual(self.editor.string, "  Foo\n  bar", "did not match")
    }
    
    func testAutoInsertAutoBracket() {
        self.editor.insertText("(")
        
        XCTAssertEqual(self.editor.string, "()", "did not add matching bracket")
    }
    
    func testSetCorrectPositionAfterAutoBracket() {
        self.editor.insertText("(")
        
        XCTAssertEqual(self.editor.selectedRange().location, 1, "did not set correct location")
    }
}
