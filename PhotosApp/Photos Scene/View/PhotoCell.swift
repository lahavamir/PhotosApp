//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    
    
    // MARK: - outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView?{
        didSet{
            guard let imageView = imageView else { return }
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    
    // MARK: - life cycle

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // hide spiner
        stopUpLoading()
        // Initialization code
    }
    
    
    
    // MARK: - methods

    func bind(image:UIImage)
    {
        imageView?.image = image
    }
    
    func shouldStartActivityIndicator(_ start:Bool)
    {
        if start {
            startUpLoading()
        }else {
            stopUpLoading()
        }
    }
    
    // start uploading photos
    func startUpLoading()
    {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    // uploading is finished or something went wrong
    // stop sppiner and hide it
     func stopUpLoading()
     {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
     }
    
    override func prepareForReuse() {
        imageView?.image = nil
        stopUpLoading()
    }

}
