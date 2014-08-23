//
//  AppDelegate.swift
//  Fiddlings
//
//  Created by Priit Haamer on 22.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        
        // Get rid of the initial view controller and window
        for window in NSApplication.sharedApplication().windows as [NSWindow] {
            window.contentViewController = nil
            window.releasedWhenClosed = true
            window.windowController()?.close()
        }
        
        if let cntrlr = NSDocumentController.sharedDocumentController() as? NSDocumentController {
            var error: NSError?
            cntrlr.openUntitledDocumentAndDisplay(true, error: &error)
        }
    }
    
}
