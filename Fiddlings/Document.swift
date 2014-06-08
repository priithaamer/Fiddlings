//
//  Document.swift
//  Fiddlings
//
//  Created by Priit Haamer on 08.06.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

    init() {
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
        let windowController = storyboard.instantiateInitialController() as NSWindowController
        self.addWindowController(windowController)
                                    
    }

}
                                
