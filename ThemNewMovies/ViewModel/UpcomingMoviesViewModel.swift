//
//  UpcomingMoviesViewModel.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

class UpcomingMoviesViewModel {

    private let upcomingMovies: UpcomingMovies
    
    public init(upcomingMovies: UpcomingMovies) {
        self.upcomingMovies = upcomingMovies
    }
    
    var movies: [Movie] {
        return upcomingMovies.results
    }
    
    var count: Int {
        return upcomingMovies.results.count
    }
    
    var totalCount: Int {
        return upcomingMovies.totalResults
    }
    
    var currentPage: Int {
        return upcomingMovies.page
    }
    
    var totalPages: Int {
        return upcomingMovies.totalPages
    }
    
}
