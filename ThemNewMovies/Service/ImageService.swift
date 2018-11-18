//
//  ImageService.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class ImageService {

    enum ServiceError: Error {
        case invalidURL
    }
    
    // -----
    // Download image from TMDb
    // -----
    func downloadImage(url: String, _ completion: @escaping (NetworkResult<UIImage>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.error(ServiceError.invalidURL))
        }
        
        let client = HttpClient()
        client.downloadImage(url) { (result) in
            switch result {
            case .success(let image):
                completion(.success(image))
                break
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
}
