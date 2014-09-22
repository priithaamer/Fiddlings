//
//  PreviewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 16.09.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa
import WebKit

class PreviewController: NSViewController, DocumentDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBOutlets
    @IBOutlet var webview: WebView!
    
    override var representedObject: AnyObject? {
        didSet {
            if let document = representedObject as? Document {
                updateWebView(document.html)
                
                document.delegate = self
            }
            
        }
    }
    
    func updateWebView(str: String) {
        webview.mainFrame.loadHTMLString(str, baseURL:nil)
    }
    
    func htmlDidChange(document: Document) {
        updateWebView(document.html)
    }
}

