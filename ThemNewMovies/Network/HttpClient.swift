//
//  HttpClient.swift
//  ThemNewMovies
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HttpClient {
    enum RequestError: Error {
        case invalidMethod
        case downloadError
    }

    // -----
    // Wrapper methods that allow the network engine to be easily replaceable
    // -----
    
    func request(_ url: URL, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (NetworkResult<Data>) -> Void) {
        // --
        // Setup Alamofire to handle the network requests
        // --
        // Convert our method value to the Alamofire enum
        guard let alamofireMethod = Alamofire.HTTPMethod(rawValue: method.rawValue) else {
            return completion(.error(RequestError.invalidMethod))
        }
        
        // Create alamofire request
        let request = Alamofire.request(url,
            method: alamofireMethod,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers)
        
        // Validate the response
        request.validate(statusCode: 200..<300)
        
        // Request data
        request.responseData(completionHandler: { (response) in
            // Handle response
            switch response.result {
            case .success(let data):
                completion(.success(data))
                break
            case .failure(let error):
                completion(.error(error))
            }
        })
    }
    
    func downloadImage(_ url: URL, completion: @escaping (NetworkResult<UIImage>) -> Void) {
        // --
        // Setup AlamofireImage to handle the image download
        // --
        
        let downloader = ImageDownloader()
        let urlRequest = URLRequest(url: url)
        
        downloader.download(urlRequest) { response in
            
            if let image = response.result.value {
                completion(.success(image))
            } else {
                completion(.error(RequestError.downloadError))
            }
        }
    }
    
}

