//
//  MovieViewModel.swift
//  ThemNewMovies
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class MovieViewModel {
    
    private let movie: Movie
    private let calendar: Calendar
    private let dateFormatter: DateFormatter
    
    public init(movie: Movie) {
        self.movie = movie
        self.calendar = Calendar.current
        self.dateFormatter = DateFormatter()
        self.dateFormatter.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
    }
    
    var title: String {
        return movie.title
    }
    
    var originalTitle: String {
        return movie.originalTitle
    }
    
    var overview: String {
        return movie.overview
    }
    
    var releaseYear: String {
        let dateComponents = calendar.dateComponents([.year], from: movie.releaseDate)
        
        guard let year = dateComponents.year else {
            return ""
        }
        return "\(year)"
    }
    
    var releaseDate: String {
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: movie.releaseDate)
    }
    
    var releaseTimeFromNow: String {
        return movie.releaseDate.getElapsedTime()
    }

}
