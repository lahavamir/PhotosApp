//
//  PhotosModel.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import Photos
import UIKit

protocol PhotosModelDelegate:class{
    func upload(error:APIError)
}

class PhotosModel {
    
    // MARK: - var
    
    fileprivate var allPhotos : PHFetchResult<PHAsset>? = nil
    fileprivate let fetchOptions = PHFetchOptions()
    
    // set of index preforming upload
    fileprivate var uploadIndex = Set<IndexPath>() {
        didSet{
            print(uploadIndex)
        }
    }
    
    // number of items load from user gallery
    // used by collection view
    var numberOfItems:Int {
        return allPhotos?.count ?? 0
    }
    
    weak var delegate:PhotosModelDelegate?
    
    //serial Queue
    fileprivate let serialQueue = DispatchQueue(label: "com.la-labs.SerialUploadImageQueue")
    
    
    
    // api service must conform to APIServiceProtocol
    // can be mock service
    fileprivate let apiService:APIServiceProtocol
    
    
    // MARK: - initiation

    init(apiService:APIServiceProtocol) {
        self.apiService = apiService
    }
    

    // MARK: - methods

    
    // fetch images from phone gallery
    func fetchUserPhotos(complition:(Bool)->())
    {
        self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        complition(true)
    }
    
    
    // get image for cell at index path
    // convert phasset to uiimage
    func getImage(at indexPath:IndexPath, targetSize:CGSize, complition:@escaping ((UIImage)->()))
    {
        guard let asset = allPhotos?.object(at: indexPath.row) else { return }
        
        let options = PHImageRequestOptions()
        options.version = .original
        
        // request image from  asset with target size (cell frame size)
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill,options: options) { image, _ in
            guard let image = image else { return }
            complition(image)
        }
    }
    
    // helper
    // check if index path is uploading
    // if true make sure activity indicator is working
    func isUploading(at indexPath:IndexPath) -> Bool
    {
        return uploadIndex.contains(indexPath)
    }
    
    func updateUpload(indexPath:IndexPath){
        uploadIndex.insert(indexPath)
    }
    
    
    // api call
    // upload image to imgur
    func upload(image:UIImage?, at indexPath:IndexPath, complition:@escaping (Bool)->())
    {
        guard let image = image  else {
            return
        }
        
        serialQueue.sync {
            // build quary
            let requestData = APIRequestData(baseURL: baseURL, method: .post, path: path, body: image.pngData())
            
            // use api service to upload image
            self.apiService.upload(request: requestData, type: jsonResponse.self) {[weak self] (result) in
                
                guard let strongSelf = self else { return }
                
                switch result
                {
                case .succes(let imgaeData):
                    if let url = imgaeData.data.link {
                        strongSelf.saveImage(url: url)
                    }
                    complition(true)
                
                case .error(let error):
                    // notify user something went wrong
                    strongSelf.delegate?.upload(error: error)
                    // stop activity indicator
                    complition(true)
                }
                
                // remove selected index from pool
                strongSelf.uploadIndex.remove(indexPath)
                
            }
        }
    }
    
    private func saveImage(url:String)
    {
        // get link from archiver
        if let links = SaveURLHelper.loadLinks()
        {
            // add new url
            links.urlLinks.append(url)
            
            // save to disk
            SaveURLHelper.save(links: links)
        }
    }

}



// response from imgur server
// will be save to disk

struct jsonResponse:Codable
{
    let data:ImageData
}

struct ImageData:Codable {
    let id:String?
    let link:String?
    
}


