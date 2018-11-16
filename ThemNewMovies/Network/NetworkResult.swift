//
//  NetworkResult.swift
//  ThemNewMovies
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}
