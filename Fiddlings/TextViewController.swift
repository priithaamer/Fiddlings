//
//  TextViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 16.09.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class TextViewController: NSViewController, NSTextViewDelegate, NSTextStorageDelegate {
    
    @IBOutlet var textview: CodeEditorView!
    
    @IBOutlet var cssEditor: CodeEditorView!
    
    @IBOutlet var javascriptEditor: CodeEditorView!
    
    var htmlparser: HTMLParser!
    
    var document: Document!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        htmlparser = HTMLParser(delegate: self)
        
        textview.textStorage!.delegate = self
        
        textview.font = NSFont(name: "Menlo", size: 12)
        textview.textColor = NSColor.whiteColor()
        textview.automaticQuoteSubstitutionEnabled = false
        textview.automaticDashSubstitutionEnabled = false
        textview.automaticTextReplacementEnabled = false
        textview.automaticSpellingCorrectionEnabled = false
        
        cssEditor.textStorage!.delegate = self
        
        cssEditor.font = NSFont(name: "Menlo", size: 12)
        cssEditor.textColor = NSColor.whiteColor()
        cssEditor.automaticQuoteSubstitutionEnabled = false
        cssEditor.automaticDashSubstitutionEnabled = false
        cssEditor.automaticTextReplacementEnabled = false
        cssEditor.automaticSpellingCorrectionEnabled = false
        
        javascriptEditor.textStorage!.delegate = self
        
        javascriptEditor.font = NSFont(name: "Menlo", size: 12)
        javascriptEditor.textColor = NSColor.whiteColor()
        javascriptEditor.automaticQuoteSubstitutionEnabled = false
        javascriptEditor.automaticDashSubstitutionEnabled = false
        javascriptEditor.automaticTextReplacementEnabled = false
        javascriptEditor.automaticSpellingCorrectionEnabled = false
    }
    
    override var representedObject: AnyObject? {
        didSet {
            if let doc = representedObject as? Document {
                document = doc
                textview.string = doc.html
                cssEditor.string = doc.css
                javascriptEditor.string = doc.javascript
            }
        }
    }
    
    func textStorageDidProcessEditing(notification: NSNotification!) {
        if notification.object as NSTextStorage == textview.textStorage! {
            document.html = textview.string!
        }
        
        if notification.object as NSTextStorage == cssEditor.textStorage! {
            document.css = cssEditor.string!
        }
        
        if notification.object as NSTextStorage == javascriptEditor.textStorage! {
//            document.javascript = javascriptEditor.string
        }
    }
    
    /**
    
    var htmlparser: HTMLParser!
    
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
