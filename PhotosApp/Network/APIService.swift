//
//  APIService.swift
//  PhotosApp
//
//  Created by Amir lahav on 08/04/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation

class APIService:APIServiceProtocol {
    
    
    let session:URLSession

    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func upload<T:Decodable>(request:APIRequestData, type:T.Type, complition:@escaping (Resualt<T>)->())
    {
        let session = URLSession.shared
        
        do {
            let request = try prepare(request: request)
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    
                    /// something went wrong
                    complition(Resualt.error(APIError.networkError(error)))
                }else{
                    // check response code
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode != 200{
                            complition(Resualt.error(APIError.badResponse(httpResponse.statusCode)))
                        }
                    }
                    if let data = data {
                        
                        // decode data response in generic way
                        if let object = try? JSONDecoder().decode(T.self, from: data){
                            complition(Resualt.succes(object))
                        
                        }else{

                            complition(Resualt.error(APIError.badInput))

                        }
                    }
                }
            }
            
            dataTask.resume()
        }catch 
        {
            complition(Resualt.error(APIError.badInput))
        }
        
    }
    
    
    func prepare(request:APIRequestData) throws -> URLRequest
    {
        let fullURL = "\(request.baseURL)/\(request.path)"
        guard let url = URL(string: fullURL) else {
            throw APIError.badInput
        }
        
        // create api request
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = request.method.rawValue
        apiRequest.setValue("Client-ID \(clinetId)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = request.body
        
        return apiRequest
        
    }
}
