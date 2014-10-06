//
//  WindowController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 21.09.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    override var document: AnyObject? {
        didSet {
            if let viewController = window!.contentViewController {
                viewController.representedObject = document
            }
        }
    }

}
