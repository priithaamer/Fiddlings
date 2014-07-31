//
//  SplitViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 26.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    
    var previewController: PreviewController?
    
    var textviewController: TextViewController?
    
    weak var document: Document! {
        didSet {
            if !document { return }
        
            NSLog("Set document in split view controller")
            
            // TODO: It is not correct to set the controllers here, find a better place for this
            self.textviewController = self.childViewControllers[0] as? TextViewController
            self.previewController = self.childViewControllers[1] as? PreviewController
            
            //            document.delegate = self
        
            reloadFromDocument()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // NSLog("split view did load")
    }
    
    func reloadFromDocument() {
        textviewController?.changeText(document.html)
    }
    
    func updateHTML(str: String) {
        
        document.html = str
        
        previewController?.updateWebView(str)
    }
    
}
