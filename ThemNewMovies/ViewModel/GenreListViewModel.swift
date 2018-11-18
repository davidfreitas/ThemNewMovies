//
//  GenreListViewModel.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class GenreListViewModel {
    
    private var genreViewModels: [GenreViewModel] = []
    
    init(genres: [Genre]) {
        genreViewModels = genres.map {
            return GenreViewModel(genre: $0)
        }
    }
    
    var count: Int {
        return genreViewModels.count
    }
    
    func getGenreViewModel(index: Int) -> GenreViewModel {
        return genreViewModels[index]
    }
    
    func sizeForCell(atIndexPath indexPath: IndexPath) -> CGSize {
        return (genreViewModels[indexPath.row].name as NSString).size(withAttributes: nil)
    }

}
