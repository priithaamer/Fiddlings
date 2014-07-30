//
//  TextViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 22.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class TextViewController: NSViewController, NSTextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // TODO: Configure these in interface builder once it does not crash Xcode
        textview.font = NSFont(name: "Menlo", size: 12)
        textview.richText = false
        textview.automaticQuoteSubstitutionEnabled = false
    }
    
    @IBOutlet var textview: NSTextView!
    
    // NSTextViewDelegate
    
    func textDidChange(notification: NSNotification!) {
        //        NSLog("Text did change")
        
        if let prc = self.parentViewController.childViewControllers[1] as? PreviewController {
            if var str = textview?.string {
                prc.updateWebView(str)
            }
        }
    }
    
}
