//
//  CodeEditorView.swift
//  Fiddlings
//
//  Created by Priit Haamer on 20.08.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

@IBDesignable
public class CodeEditorView: NSTextView {

//    override public func drawRect(dirtyRect: NSRect) {
//        super.drawRect(dirtyRect)
//
//        // Drawing code here.
//        NSLog("Code editor view - drawRect")
//    }
    
    // TODO: Tab width should be configurable
    override public func insertTab(sender: AnyObject!) {
        self.insertText("  ")
    }
    
    override public func insertNewline(sender: AnyObject!) {
        super.insertNewline(sender)
        
        var r = self.selectedRange()

        if r.location > 0 {
            r.location--
        }
        
        r = self.selectionRangeForProposedRange(r, granularity: .SelectByParagraph)
        
        let previousLine = self.textStorage.mutableString.substringWithRange(r)

        var j = 0
        let previousLineLength = previousLine.lengthOfBytesUsingEncoding(NSUnicodeStringEncoding)
        
        // TODO: optimize Array(previousline)[j] -- gets j-th character from string
        while (j < previousLineLength && (Array(previousLine)[j] == " " || Array(previousLine)[j] == "\t")) {
            j++
        }
        
        if (j > 0) {
            let foo = self.textStorage.mutableString.substringWithRange(NSMakeRange(r.location, j))
            
            self.insertText(foo)
        }
    }
}
