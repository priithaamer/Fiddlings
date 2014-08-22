//
//  ViewController.swift
//  CodeEditorExample
//
//  Created by Priit Haamer on 20.08.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa
import CodeEditorKit

class ViewController: NSViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textview.font = NSFont(name: "Menlo", size: 12)
        textview.richText = false
        textview.automaticQuoteSubstitutionEnabled = false
        
        textview.backgroundColor = NSColor.clearColor()
                                    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }

    @IBOutlet var textview: CodeEditorView!

}

