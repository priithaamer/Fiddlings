//
//  SplitViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 26.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NSLog("split view did load")
    }
    
    // Did not work
//    override func prepareForSegue(segue: NSStoryboardSegue!, sender: AnyObject!) {
//        super.prepareForSegue(segue, sender: sender)
//        
//        NSLog("Prepare for segue")
//    }
    
    
//    @IBOutlet var textViewController: TextViewController?
//    
//    @IBOutlet var previewController: PreviewController?
}
