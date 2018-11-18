//
//  UpcomingMovies.swift
//  ThemNewMovies
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

struct MovieSearch: Codable {
    
    let results: [Movie]
    let totalResults: Int
    let page: Int
    let totalPages: Int
    

    enum CodingKeys: String, CodingKey {
        case results
        case totalResults = "total_results"
        case page
        case totalPages = "total_pages"
    }
}
