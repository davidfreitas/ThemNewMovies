//
//  ViewModelTests.swift
//  ThemNewMoviesTests
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import XCTest
@testable import ThemNewMovies

class ViewModelTests: XCTestCase {

    func testMovieViewModel() {
        let movie = Movie(id: 1, title: "Scarface", originalTitle: "Scarface", overview: "The world is yours", posterPath: "sayhello.jpg", backdropPath: "littlefriend.jpg", releaseDate: Date(), genreIds: [1])
        
        let viewModel = MovieViewModel.init(movie: movie)
        
        XCTAssertEqual(movie.title, viewModel.title)
    }

}
