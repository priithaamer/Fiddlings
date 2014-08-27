//
//  TextViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 22.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class TextViewController: NSViewController, NSTextViewDelegate, NSTextStorageDelegate {
    
    @IBOutlet var textview: CodeEditorView!
    
    var htmlparser: HTMLParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        htmlparser = HTMLParser(delegate: self)
        
        textview.textStorage.delegate = self
        
        // TODO: Configure these in interface builder once it does not crash Xcode
        textview.font = NSFont(name: "Menlo", size: 12)
        textview.richText = false
        textview.automaticQuoteSubstitutionEnabled = false
        textview.automaticDashSubstitutionEnabled = false
        
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
            }
        }
    }
    
    /**
    
    // Noodleeditis oli selline asi
    // [self performSelector:@selector(parse:) withObject:self afterDelay:0.0];
    func textStorageDidProcessEditing(notification: NSNotification!) {
        var err: NSError? = nil
        
        //parse string (which populates entries and attributesForEntry
        var result: PKAssembly? = htmlparser.parseString(textview.string, error: &err) as? PKAssembly
    }
    
    func formatToken(token: PKToken, color: NSColor) {
        var range : NSRange = NSMakeRange(Int(token.offset), token.stringValue.utf16Count)
        
        // textview.textStorage.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        textview.layoutManager.addTemporaryAttribute(NSForegroundColorAttributeName, value: color, forCharacterRange: range)

    }
    
    func popToken(assembly: PKAssembly) -> PKToken {
        var token = assembly.pop() as PKToken
        NSLog("Popping token \(token.stringValue)")
        return token
    }
    
    func parser(parser: HTMLParser, didMatchTagName: PKAssembly) {
        var token = popToken(didMatchTagName)
        formatToken(token, color: NSColor.redColor())
    }
    
    func parser(parser: HTMLParser, didMatchComment: PKAssembly) {
        formatToken(popToken(didMatchComment), color: NSColor.greenColor())
    }
    
    func parser(parser: HTMLParser, didMatchAttr: PKAssembly) {
        formatToken(popToken(didMatchAttr), color: NSColor.magentaColor())
    }
    
    //    func parser(parser: HTMLParser, didMatchStyleElement: PKAssembly) {
    //        NSLog("did match stylesheet")
    //    }
    **/
    
}
