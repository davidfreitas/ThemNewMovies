//
//  GenreViewModel.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

class GenreViewModel {

    private let genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var name: String {
        return genre.name
    }
    
}
