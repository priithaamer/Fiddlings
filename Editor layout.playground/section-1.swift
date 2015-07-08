// Playground - noun: a place where people can play

import Cocoa
import XCPlayground

var editor = NSTextView(frame: NSRect(x: 0, y: 0, width: 350, height: 300))

editor.string = "Jeess\nNoo"
editor.backgroundColor = NSColor.grayColor()

XCPShowView("textview", editor)

// Saab tekstiala kõrguse
// http://stackoverflow.com/questions/11237622/using-autolayout-with-expanding-nstextviews/14469815#14469815 ja http://stackoverflow.com/questions/21871705/intrinsic-content-size-for-nstextview
var layoutManager = editor.layoutManager
var textContainer = editor.textContainer
layoutManager?.ensureLayoutForTextContainer(textContainer!)
var size = layoutManager?.usedRectForTextContainer(textContainer!).size

/** -----------------------------------------

http://stackoverflow.com/questions/14668303/sequential-selection-among-multiple-nstextviews

NSLayoutManager * layout = [[NSLayoutManager alloc] init];
NSString * storedString = @"A\nquick\nBrown\nFox";
NSTextStorage * storage = [[NSTextStorage alloc] initWithString:storedString];
[storage addLayoutManager:layout];

//I assume you have a parent view to add the text views
NSView * view;

//Assuming you want to split up into separate view by line break
NSArray * paragraphs = [storedString componentsSeparatedByString:@"\n"];
for (NSString * paragraph in paragraphs)
{
    NSSize paragraphSize = [paragraph sizeWithAttributes:@{}];
    //Create a text container only big enough for the string to be displayed by the text view
    NSTextContainer * paragraphContainer = [[NSTextContainer alloc] initWithContainerSize:paragraphSize];
    [layout addTextContainer:paragraphContainer];
    
    //Use autolayout or calculate size/placement as you go along
    NSRect lazyRectWithoutSizeOrPlacement = NSMakeRect(0, 0, 0, 0);
    NSTextView * textView = [[NSTextView alloc] initWithFrame:lazyRectWithoutSizeOrPlacement
    textContainer:paragraphContainer];
    [view addSubview:textView];
}
**/

// Line numbers! http://www.noodlesoft.com/blog/2008/10/05/displaying-line-numbers-with-nstextview/
