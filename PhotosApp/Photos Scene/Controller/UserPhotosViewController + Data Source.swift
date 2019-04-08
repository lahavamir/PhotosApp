//
//  UserPhotosViewController + Data Source.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

extension UserPhotosViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.uniqueIdentifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        // get image and bind to cell
        model.getImage(at: indexPath, targetSize: cell.frame.size) { (image) in
            DispatchQueue.main.async {
                
                // must be on main queue
                cell.bind(image: image)
            }
        }
        
        // check if need to spin Activity Indicator
        cell.startActivityIndicator(model.isUploading(at: indexPath))
        
        
        return cell
    }
    
    
    
}
