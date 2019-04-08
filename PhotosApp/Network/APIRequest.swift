//
//  APIRequest.swift
//  PhotosApp
//
//  Created by Amir lahav on 07/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation

public enum HTTPMethod:String
{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    /// and more
}


struct HTTPHeader {
    let field: String
    let value: String
}

protocol RequestPorotocol
{
    var baseURL:String { get }
    var path:String { get }
    var method:HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [HTTPHeader]? { get }
    var body: Data? { get }
}



struct APIRequestData:RequestPorotocol
{
    let baseURL: String
    let path: String
    let method: HTTPMethod
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(baseURL:String, method: HTTPMethod, path: String) {
        self.baseURL = baseURL
        self.method = method
        self.path = path
    }
    
    init(baseURL:String,method: HTTPMethod, path: String ,body: Data?) {
        self.baseURL = baseURL
        self.method = method
        self.path = path
        self.body = body
    }
    
}


enum APIError:Error
{
    case networkError(Error)
    case badInput
    case badResponse(Int)
}

enum Resualt<T:Decodable>
{
    case succes(T)
    case error(APIError)
}
