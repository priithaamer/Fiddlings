//
//  WindowController.swift
//  Fiddlings
//
//  Created by Priit Haamer on 22.07.14.
//  Copyright (c) 2014 Priit Haamer. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    // MARK: Types
    
//    struct SegueIdentifiers {
//        static let showAddItemViewController = "showAddItemViewController"
//    }
    
    // MARK: IBOutlets
//    
//    @IBOutlet
//    var shareButton: NSButton!
    
    // MARK: View Life Cycle
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        let action = Int(NSEventMask.LeftMouseDownMask.toRaw())
//        shareButton.sendActionOn(action)
//    }
    
    // MARK: Overrides
    
    override var document: AnyObject! {
        didSet {
            NSLog("did set document")
//            let listViewController = window.contentViewController as ListViewController
//            listViewController.document = document as? ListDocument
        }
    }
    
//    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject!) {
//        if segue.identifier == SegueIdentifiers.showAddItemViewController {
//            let listViewController = window.contentViewController as ListViewController
//            
//            let addItemViewController = segue.destinationController as AddItemViewController
//            
//            addItemViewController.delegate = listViewController
//        }
//    }
    
    
    // MARK: IBActions
    
//    @IBAction
//    func shareDocument(sender: NSButton) {
//        if let listDocument = document as? ListDocument {
//            let listContents = ListFormatting.stringFromListItems(listDocument.list.items)
//            
//            let sharingServicePicker = NSSharingServicePicker(items: [listContents])
//            
//            let preferredEdge = NSRectEdge(CGRectEdge.MinYEdge.toRaw())
//            sharingServicePicker.showRelativeToRect(NSZeroRect, ofView: sender, preferredEdge: preferredEdge)
//        }
//    }
}
