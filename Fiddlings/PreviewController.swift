//
//  PreviewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 23.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa
import WebKit

class PreviewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        NSLog("preview view did load")
        
//        var webview = WebView(frame: self.view.frame)
//        self.view.addSubview(webview)
    }
    
    // MARK: IBOutlets
    @IBOutlet var webview: WebView?
    
//    override var representedObject: AnyObject? {
//        didSet {
//            // Update the view, if already loaded.
//        }
//    
//    }
//    
//    func myfunc() -> String {
//        return "Foo"
//    }
    
    func updateWebView(str: String) {
//        NSLog(str)
        webview?.mainFrame.loadHTMLString(str, baseURL:nil)
    }
    
}


