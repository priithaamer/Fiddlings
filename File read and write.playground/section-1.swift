// Playground - noun: a place where people can play

import Foundation
import Cocoa

let json = "{\"version\": \"1.0\",\n\"html\": \"<html><body>Test 💩</body></html>\",\n\"css\": \"body { color: red; }\",\n\"javascript\": \"alert('blah')\"\n}"

if let data = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
    var jsonerror: NSError?
    
    let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonerror) as NSDictionary
    
    let html = jsonData["html"]

}


