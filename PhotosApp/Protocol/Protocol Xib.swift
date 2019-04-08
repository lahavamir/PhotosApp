//
//  Protocol Xib .swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

protocol Xibable {
    
    static var nibName:String {get}
}

extension Xibable where Self:UIView {
    
    static var nibName:String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
