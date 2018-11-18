//
//  UpcomingMoviesViewModel.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

class SearchMoviesViewModel {

    public typealias UpdatedClosure = () -> ()
    public typealias ErrorClosure = (Error) -> ()
    
    private var movieSearch: MovieSearch? {
        didSet {
            self.updatedMovies?()
        }
    }
    
    private var movieViewModels: [MovieViewModel] = []
    
    private let service: MovieService
    private var query: String
    
    public var updatedMovies: UpdatedClosure?
    public var errorHandler: ErrorClosure?
    
    init() {
        service = MovieService()
        query = ""
    }
    
    private func fetchData(page: Int = 1) {
        isLoading = true

        service.searchMovies(query: query, page: page) { [weak self] (result) in
            self?.isLoading = false
            
            switch result {
            case .success(let movieSearch):
                self?.setMovieSearch(movieSearch)
                break
            case .error(let error):
                self?.errorHandler?(error)
            }
        }
    }
    
    private func setMovieSearch(_ movieSearch: MovieSearch) {
        if currentPage == 1 {
            movieViewModels = movieSearch.results.map {
                return MovieViewModel(movie: $0)
            }
        } else {
            movieViewModels.append(
                contentsOf: movieSearch.results.map {
                    return MovieViewModel(movie: $0)
            })
        }
        
        self.movieSearch = movieSearch
    }
    
    func getMovieViewModel(index: Int) -> MovieViewModel {
        return movieViewModels[index]
    }
    
    func refresh() {
        fetchData()
    }
    
    func loadNextPage() {
        if hasNextPage && !isLoading {
            fetchData(page: currentPage + 1)
        }
    }
    
    func setQuery(query: String) {
        self.query = query
    }
    
    var isLoading: Bool = false
    
    var count: Int {
        return movieViewModels.count
    }
    
    var totalCount: Int {
        guard let movieSearch = movieSearch else {
            return 0
        }
        return movieSearch.totalResults
    }
    
    var currentPage: Int {
        guard let movieSearch = movieSearch else {
            return 0
        }
        return movieSearch.page
    }
    
    var totalPages: Int {
        guard let movieSearch = movieSearch else {
            return 0
        }
        return movieSearch.totalPages
    }
    
    var hasNextPage: Bool {
        return currentPage < totalPages
    }
    
}
