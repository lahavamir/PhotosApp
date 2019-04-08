//
//  UserPhotosViewController.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import UIKit

class UserPhotosViewController: UIViewController, Alertable, PhotosModelDelegate {

    
    // MARK: - var

    let model:PhotosModel
    var numberOfPhotsForRow:Int = 3{
        didSet{
            photosCollection?.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: - life cycle
    
    init(model:PhotosModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        model.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observe device orientation
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

        // Do any additional setup after loading the view.
        fetchPhotos()
    }
    
    deinit {
        // remove observation
        NotificationCenter.default.removeObserver(self)
    }

    
    // MARK: - outlets

    @IBOutlet weak var photosCollection: UICollectionView? {
        didSet{
            
            guard let collection = photosCollection else {
                return
            }
            
            // common init
            collection.delegate = self
            collection.dataSource = self
            collection.registerNib(PhotoCell.self)
            
            // layout modificaiton
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
            collection.collectionViewLayout = layout
        }
    }
    
    

    
}
