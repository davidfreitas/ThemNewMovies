//
//  MovieService.swift
//  ThemNewMovies
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class MovieService {
    enum ServiceError: Error {
        case invalidURL
    }
    
    // -----
    // Get upcoming movie releases
    // Model: UpcomingMovies
    // -----
    func getUpcoming(_ completion: @escaping (NetworkResult<UpcomingMovies>) -> Void) {
        guard let url = URL(string: API.upcomingMoviesPath) else {
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
                        let upcoming: UpcomingMovies = try ModelDecoder.decodeJSON(withData: data)
                        completion(.success(upcoming))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
    }

}
