//
//  Constants.swift
//  ThemNewMovies
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

enum API {
    fileprivate static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    fileprivate static let apiQuery = "?api_key=\(apiKey)&language=\("apiLanguage".localized)"
    fileprivate static let basePath = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    static let upcomingMoviesPath = "\(basePath)movie/upcoming\(apiQuery)"
    static let searchMoviesPath = "\(basePath)search/movie\(apiQuery)"
    static let genresPath = "\(basePath)genre/movie/list\(apiQuery)"
}

enum BackropSize: String {
    case w300
    case w780
    case w1280
    case original
}

enum PosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}
