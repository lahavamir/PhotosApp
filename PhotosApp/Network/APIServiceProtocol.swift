//
//  APIServiceProtocol.swift
//  PhotosApp
//
//  Created by Amir lahav on 08/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    
    func upload<T:Decodable>(request:APIRequestData, type:T.Type, complition:@escaping (Resualt<T>)->())
}
