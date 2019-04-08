//
//  UserPhotosViewController + Delegate.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

extension UserPhotosViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    
    //MARK: collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // get screen size width
        let width = UIScreen.main.bounds.width
        
        // divid by number of photos in row
        // 5 for Landscape, 3 from Portrait
        let size:CGFloat = width / CGFloat(numberOfPhotsForRow)
        
        // return dynamic size
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        
        // make sure user didnt already uploading this photo
        if !model.isUploading(at: indexPath) {
           
            // start activity indicator after item selected
            cell.shouldStartActivityIndicator(true)
            
            // update model about the new index
            model.updateUpload(indexPath:indexPath)
            
            // upload image to imgur cloud
            model.upload(image: cell.imageView?.image, at: indexPath) { (finish) in
                // after finish upload, reload item and stop activity indicator
                if finish {
                    // must be on main queue
                    DispatchQueue.main.async {
                        collectionView.reloadItems(at: [indexPath])
                    }
                }
            }
        }
    }
}
