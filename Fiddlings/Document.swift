//
//  Document.swift
//  Fiddlings
//
//  Created by Priit Haamer on 08.06.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

//@objc
//public protocol DocumentDelegate {
//    func someDocumentDidChangeContents(document: Document)
//}

class Document: NSDocument {
    
    //    public weak var delegate: DocumentDelegate?
    
    internal var html: String
    
    override init() {
        //        super.init()
        // Add your subclass-specific initialization here.
        
        self.html = ""
        
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
                                    
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
                                    
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
                                    

        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateInitialController() as NSWindowController
        self.addWindowController(windowController)
                                    
    }
    
    override func dataOfType(typeName: String?, error outError: NSErrorPointer) -> NSData? {
        
        NSLog("dataOfType")
        
        if let data = NSKeyedArchiver.archivedDataWithRootObject(html) {
            return data
        }
        
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        outError.memory = NSError.errorWithDomain(NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return nil
    }
    
    override func readFromData(data: NSData?, ofType typeName: String?, error outError: NSErrorPointer) -> Bool {
        
        NSLog("readFromData")
        
        if let deserializedHtml = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? String {
            html = deserializedHtml
            
            // delegate?.listDocumentDidChangeContents(self)
            
            return true
        }
        
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
        outError.memory = NSError.errorWithDomain(NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return false
    }

}
                                
