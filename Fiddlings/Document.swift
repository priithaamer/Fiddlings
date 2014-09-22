//
//  Document.swift
//  Fiddlings
//
//  Created by Priit Haamer on 16.09.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

protocol DocumentDelegate {
    func htmlDidChange(document: Document)
}

class Document: NSDocument {

    internal var delegate: DocumentDelegate?
    
    internal var html:String = "" {
        didSet {
            delegate?.htmlDidChange(self)
        }
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
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
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as NSWindowController
        self.addWindowController(windowController)
    }

    override func dataOfType(typeName: String?, error outError: NSErrorPointer) -> NSData? {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        
        //        return NSKeyedArchiver.archivedDataWithRootObject(html)
        
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return nil
    }

    override func fileWrapperOfType(typeName: String!, error outError: NSErrorPointer) -> NSFileWrapper! {
        let wrapper = NSFileWrapper(regularFileWithContents: NSData())
        return wrapper
    }

    override func readFromFileWrapper(fileWrapper: NSFileWrapper!, ofType typeName: String!, error outError: NSErrorPointer) -> Bool {
        if let data = fileWrapper.regularFileContents {
            var jsonerror: NSError?
            
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonerror) as NSDictionary
            
            if json["html"] is String {
                html = json["html"] as String
            }
            
            return true
        } else {
            outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
            return false
        }
    }

}

