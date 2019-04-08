//
//  AppCoordinator.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator:Coordinator
{
    var window:UIWindow
    var pressenter: UINavigationController
    var userPhotosCoordinator:UserPhotosCoordiantor
    
    init(window:UIWindow) {
        
        self.window = window
        
        // setup container
        pressenter = UINavigationController()
        
        if #available(iOS 11.0, *) {
            pressenter.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        
        /// test contoller
        let test = UIViewController()
        test.view.backgroundColor = .brown
//        pressenter.pushViewController(test, animated: false)
        
        
        // create child coordinator
        userPhotosCoordinator = UserPhotosCoordiantor(pressenter: pressenter)
        
    }
    
    
    func start() {
        
        self.window.rootViewController = pressenter
        
        // start child coordinator
        userPhotosCoordinator.start()
        
        self.window.makeKeyAndVisible()
    }
    
}


