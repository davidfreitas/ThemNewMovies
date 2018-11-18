//
//  GenreService.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class GenreService {
    enum ServiceError: Error {
        case invalidURL
    }
    
    // -----
    // Get movie genres
    // Model: Genre
    // -----
    func getGenres(_ completion: @escaping (NetworkResult<[Genre]>) -> Void) {
        guard let url = URL(string: API.genresPath) else {
            return completion(.error(ServiceError.invalidURL))
        }
        
        let client = HttpClient()
        client.request(
            url,
            method: .get,
            parameters: nil,
            headers: nil) { (result) in
                // handle result
                switch result {
                case .success(let data):
                    do {
                        let list: GenreList = try ModelDecoder.decodeJSON(withData: data)
                        completion(.success(list.genres))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
    }
    
}
