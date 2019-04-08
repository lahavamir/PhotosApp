//
//  Links.swift
//  PhotosApp
//
//  Created by Amir lahav on 08/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation

class URLLinks:NSObject,NSCoding
{
    
    // save image url for loading
    var urlLinks:[String] = []
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(urlLinks, forKey: "links")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.urlLinks = aDecoder.decodeObject(forKey: "links") as! [String]
    }
    
}


class SaveURLHelper {
    
    // archive links array
    static func save(links: URLLinks) {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: links)
        UserDefaults.standard.set(data, forKey: "links")
    }
    
    // anarchive links array
    static func loadLinks() -> URLLinks?  {
        guard let data = UserDefaults.standard.data(forKey: "links") else {
            
            // if we havent save any links yet
            // create new one
            let urlLink = URLLinks()
            save(links: urlLink)
            
            return urlLink
        }
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? URLLinks
    }
}
