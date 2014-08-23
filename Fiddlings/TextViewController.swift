//
//  TextViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 22.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class TextViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textview: CodeEditorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // TODO: Configure these in interface builder once it does not crash Xcode
        textview.font = NSFont(name: "Menlo", size: 12)
        textview.richText = false
        textview.automaticQuoteSubstitutionEnabled = false
        
        textview.backgroundColor = NSColor.clearColor()
    }
    
    // NSTextViewDelegate
    
    func changeText(str:String) {
        textview.string = str
    }
    
    func textDidChange(notification: NSNotification!) {
        if let parent = self.parentViewController as? SplitViewController {
            if let str = textview?.string {
                parent.updateHTML(str)
                
                //                var textStorage = textview.textStorage
                //                textStorage.addAttribute(NSForegroundColorAttributeName, value: NSColor.redColor(), range: NSMakeRange(1, 9))
            }
        }
        
        //        if let prc = self.parentViewController.childViewControllers[1] as? PreviewController {
        //            if var str = textview?.string {
        //                prc.updateWebView(str)
        //            }
        //        }
    }
    
}
