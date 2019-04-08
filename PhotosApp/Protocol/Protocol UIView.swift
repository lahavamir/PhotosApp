//
//  Protocol UIView.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

// uniqueIdentifier for dequeue reusable cell
protocol ReusableView {
    
    static var uniqueIdentifier:String {get}
}

// defualt implementation
extension ReusableView where Self:UIView {
    
    static var uniqueIdentifier:String {
        return NSStringFromClass(self)
    }
}
