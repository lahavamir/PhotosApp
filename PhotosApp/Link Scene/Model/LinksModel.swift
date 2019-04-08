//
//  LinksModel.swift
//  PhotosApp
//
//  Created by Amir lahav on 08/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation

class LinkModel {
    
    var links:URLLinks? = nil
    
    var numberOfRows:Int {
        return links?.urlLinks.count ?? 0
    }
    
    // fetch links and reload table view
    func fetchLinks(compliton:(Bool)->())
    {
        getLinks()
        compliton(true)
    }
    
    // get save links
    func getLinks()
    {
        links = SaveURLHelper.loadLinks()
    }
    
    // get link for index path
    func url(at indexPath:IndexPath) -> String?
    {
        return links?.urlLinks[indexPath.row]
    }
    
    
    
}
