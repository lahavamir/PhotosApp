//
//  Protocol + Coordinator.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit


// coordinator protocl. every flow start with coordinator
protocol Coordinator {
    
    var pressenter:UINavigationController { get }
    func start()
}
