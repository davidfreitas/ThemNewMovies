//
//  Constants.swift
//  ThemNewMovies
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

enum API {
    fileprivate static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    fileprivate static let apiQuery = "?api_key=\(apiKey)"
    fileprivate static let basePath = "https://api.themoviedb.org/3"
    static let upcomingMoviesPath = "\(basePath)/movie/upcoming\(apiQuery)"
}
