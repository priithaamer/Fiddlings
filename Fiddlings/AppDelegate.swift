//
//  AppDelegate.swift
//  Fiddlings
//
//  Created by Priit Haamer on 22.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

// TODO: Quick look support

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(notification: NSNotification) {
//        NSLog("Application did finish launching")
        
        // Get rid of the initial view controller and window
        
        if let windows = NSApplication.sharedApplication().windows as? [NSWindow] {
            let window = windows[windows.endIndex - 1]
            
            window.contentViewController = nil
            window.releasedWhenClosed = true
            window.windowController().close()
            
            if let cntrlr = NSDocumentController.sharedDocumentController() as? NSDocumentController {
                var error: NSError?
                cntrlr.openUntitledDocumentAndDisplay(true, error: &error)
            }
        }
    }
    
//    func applicationShouldOpenUntitledFile(sender: NSApplication) -> Bool {
//        
//        NSLog("im here")
//        
//        return true
//    }
}
