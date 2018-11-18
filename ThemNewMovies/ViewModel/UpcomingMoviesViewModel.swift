//
//  UpcomingMoviesViewModel.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

class UpcomingMoviesViewModel {

    public typealias UpdatedClosure = () -> ()
    
    private var upcomingMovies: UpcomingMovies? {
        didSet {
            self.updatedMovies?()
        }
    }
    
    private var movieViewModels: [MovieViewModel] = []
    
    private let service: MovieService
    
    public var updatedMovies: UpdatedClosure?
    
    init() {
        service = MovieService()
    }
    
    private func fetchData(page: Int = 1) {
        isLoading = true
        service.getUpcomingMovies(page: page) { [weak self] (result) in
            self?.isLoading = false
            
            switch result {
            case .success(let upcomingMovies):
                self?.setUpcomingMovies(upcomingMovies)
                break
            case .error(_):
                break
            }
        }
    }
    
    private func setUpcomingMovies(_ upcomingMovies: UpcomingMovies) {
        if currentPage == 1 {
            movieViewModels = upcomingMovies.results.map {
                return MovieViewModel(movie: $0)
            }
        } else {
            movieViewModels.append(
                contentsOf: upcomingMovies.results.map {
                    return MovieViewModel(movie: $0)
            })
        }
        
        self.upcomingMovies = upcomingMovies
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
    
    var isLoading: Bool = false
    
    var movies: [Movie] {
        guard let upcomingMovies = upcomingMovies else {
            return [Movie]()
        }
        return upcomingMovies.results
    }
    
    var count: Int {
        return movieViewModels.count
    }
    
    var totalCount: Int {
        guard let upcomingMovies = upcomingMovies else {
            return 0
        }
        return upcomingMovies.totalResults
    }
    
    var currentPage: Int {
        guard let upcomingMovies = upcomingMovies else {
            return 0
        }
        return upcomingMovies.page
    }
    
    var totalPages: Int {
        guard let upcomingMovies = upcomingMovies else {
            return 0
        }
        return upcomingMovies.totalPages
    }
    
    var hasNextPage: Bool {
        return currentPage < totalPages
    }
    
}
