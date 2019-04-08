//
//  UserPhotosCoordinator.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class UserPhotosCoordiantor : NSObject, Coordinator {
    
    var pressenter: UINavigationController
    weak var rootViewContrller:UserPhotosViewController?

    init(pressenter:UINavigationController) {
        self.pressenter = pressenter
        super.init()
    }
    
    func start() {
        
        // imgur api service
        let apiService = APIService()
        
        // create model injected with api service
        let model = PhotosModel(apiService: apiService)
        
        // inject model to view controller
        // can be mock model for test
        let vc = UserPhotosViewController(model: model)
        
        // view controller proporties
        vc.title = "Photos"
        let link = UIBarButtonItem(title: "links", style: .done, target: self, action: #selector(self.pushURLlinkController))
        vc.navigationItem.setRightBarButton(link, animated: false)
        
        // push photos view controller
        pressenter.pushViewController(vc, animated: false)
        
        // keep weak referance to root controller
        rootViewContrller = vc
        

    }
    
    
    // push link controller
    @objc func pushURLlinkController()
    {
        // create model
        let model = LinkModel()
        
        // inject model to view controller
        let vc = UploadLinkViewController(model: model)
        
        // proporties
        vc.title = "links"
        
        // push controller
        pressenter.pushViewController(vc, animated: true)
        
    }

}
