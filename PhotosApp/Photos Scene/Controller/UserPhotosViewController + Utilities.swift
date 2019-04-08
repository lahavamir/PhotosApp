//
//  UserPhotosViewController + Utilities.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import Photos


extension UserPhotosViewController
{
    
    // gallery authorization helper
    func didUserAuthorizedGallery(complition: @escaping ((Bool)->())) {
        // check authorization status
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            
            // status is not determined
            // pop up request authorization
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                switch newStatus{
                case .authorized:
                    
                    // user grant authorization
                    complition(true)
                default:
                    
                    // user didn't grant authorization
                    complition(false)
                }
            }
        case .restricted:
            complition(false)
        case .denied:
            complition(false)
        case .authorized:
            complition(true)
        }
    }
    
    
    // fetch user photos
    func fetchPhotos()
    {
        // check if user did Authorized Gallery
        // if true, start fetch photos
        didUserAuthorizedGallery {[weak self] (authorized) in
            guard let strongSelf = self else { return }
            switch authorized{
            case true:
                strongSelf.model.fetchUserPhotos(complition: {(finish) in
                    DispatchQueue.main.async {
                        // reload must be on the main queue
                        strongSelf.photosCollection?.reloadData()
                    }
                })
            case false:
                print("didnt get authorized")
            }
        }
    }
    
    
    // device orientation helper
    @objc func rotated() {
        
        // update number of rows according to device orientation
        if UIDevice.current.orientation.isLandscape {
            numberOfPhotsForRow = 5
        } else {
            numberOfPhotsForRow = 3
        }
    }
    
    
    // update user when error occur
    func upload(error: APIError) {
        
        // alert user when error comes up
        // must be on main queue
        DispatchQueue.main.async {
            self.alert(title: "OHH", body: "Something went wrong with image uploading, please try again later", actionTitle: "OK", handler: nil)
            
        }
    }
    
}
