//
//  MockApiService.swift
//  PhotosApp
//
//  Created by Amir lahav on 08/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation

class MockApiService: APIServiceProtocol {
    func upload<T>(request: APIRequestData, type: T.Type, complition: @escaping (Resualt<T>) -> ()) where T : Decodable {
        // this is mock service
    }
    
    
}
