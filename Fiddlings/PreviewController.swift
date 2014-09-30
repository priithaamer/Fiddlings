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
                updateWebView(document.html, css: document.css, javascript: document.javascript)
                
                document.delegate = self
            }
            
        }
    }
    
    func updateWebView(html: String, css: String, javascript: String) {
        var str = "<html><style>\(css)</style><body>\(html)<script type=\"text/javascript\">\(javascript)</script></body></html>"
        
        webview.mainFrame.loadHTMLString(str, baseURL:nil)
    }
    
    func htmlDidChange(document: Document) {
        updateWebView(document.html, css: document.css, javascript: document.javascript)
    }
    
    func cssDidChange(document: Document) {
        updateWebView(document.html, css: document.css, javascript: document.javascript)
    }
    
    func javascriptDidChange(document: Document) {
        updateWebView(document.html, css: document.css, javascript: document.javascript)
    }
}

