//
//  ViewController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 16.09.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class ViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            if !(representedObject != nil) { return }
            
            for viewController in self.childViewControllers as [NSViewController] {
                viewController.representedObject = representedObject
            }
        }
    }


}

