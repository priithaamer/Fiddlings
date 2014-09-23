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
    
    internal var css:String = ""
    
    internal var javascript:String = ""
    
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

    override func fileWrapperOfType(typeName: String!, error outError: NSErrorPointer) -> NSFileWrapper! {
        let data = [
            "version": "1.0",
            "html": html,
            "css": css,
            "javascript": javascript
        ]
        
        var jsonError: NSError?
        
        let json:NSData = NSJSONSerialization.dataWithJSONObject(data, options:nil, error: &jsonError)!
        
        return NSFileWrapper(regularFileWithContents: json)
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

