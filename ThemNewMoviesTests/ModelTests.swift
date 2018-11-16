//
//  ModelTests.swift
//  ThemNewMoviesTests
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import XCTest
@testable import ThemNewMovies

class ModelTests: XCTestCase {

    // -----
    // Test Movie decoding
    // -----
    func testMovie() {
        let jsonString = """
            {
                "vote_count": 62,
                "id": 507569,
                "video": false,
                "vote_average": 5.6,
                "title": "The Seven Deadly Sins: Prisoners of the Sky",
                "popularity": 176.92,
                "poster_path": "/r6pPUVUKU5eIpYj4oEzidk5ZibB.jpg",
                "original_language": "en",
                "original_title": "劇場版 七つの大罪 天空の囚われ人",
                "genre_ids": [ 28, 12, 14, 16],
                "backdrop_path": "/uKwOX7MtKlAaGeCQe6c4jc1vZpj.jpg",
                "adult": false,
                "overview": "Traveling ...",
                "release_date": "2018-08-18"
            }
        """
        
        guard let data = jsonString.data(using: String.Encoding.utf8) else {
            fatalError()
        }
        
        let movie: Movie? = ModelDecoder.decodeJSON(withData: data)
        
        // Test decoding success
        XCTAssertNotNil(movie)
        
        // Test decoded data
        XCTAssertEqual(movie?.title, "The Seven Deadly Sins: Prisoners of the Sky")
    }
    
    // -----
    // Test Upcoming decoding
    // -----
    func testUpcoming() {
        let jsonString = """
        {
            "results": [
                {
                    "vote_count": 62,
                    "id": 507569,
                    "video": false,
                    "vote_average": 5.6,
                    "title": "The Seven Deadly Sins: Prisoners of the Sky",
                    "popularity": 176.92,
                    "poster_path": "/r6pPUVUKU5eIpYj4oEzidk5ZibB.jpg",
                    "original_language": "en",
                    "original_title": "劇場版 七つの大罪 天空の囚われ人",
                    "genre_ids": [ 28, 12, 14, 16],
                    "backdrop_path": "/uKwOX7MtKlAaGeCQe6c4jc1vZpj.jpg",
                    "adult": false,
                    "overview": "Traveling ...",
                    "release_date": "2018-08-18"
                }
            ],
            "page": 1,
            "total_results": 262,
            "dates": {
                "maximum": "2018-12-11",
                "minimum": "2018-11-22"
            },
            "total_pages": 14
        }
        """
        
        guard let data = jsonString.data(using: String.Encoding.utf8) else {
            fatalError()
        }
        
        let upcoming: Upcoming? = ModelDecoder.decodeJSON(withData: data)
        
        // Test decoding success
        XCTAssertNotNil(upcoming)
        
        // Test decoded data
        XCTAssertEqual(upcoming?.totalPages, 14)
    }

}
