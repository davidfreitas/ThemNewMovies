//
//  GenreManager.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class GenreManager {
    
    static let shared = GenreManager()

    private var genres: [Genre] = []
    
    func loadGenres() {
        if Storage.fileExists("genres.json", in: .documents) {
            let genres = Storage.retrieve("genres.json", from: .documents, as: [Genre].self)
            self.genres = genres
        }
        
        fetchData()
    }
    
    private func saveGenres() {
        Storage.store(genres, to: .documents, as: "genres.json")
    }
    
    private func fetchData() {
        let service = GenreService()
        service.getGenres { [weak self] (result) in
            switch result {
            case .success(let genres):
                self?.genres = genres
                self?.saveGenres()
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    func getGenre(withId id: Int) -> Genre? {
        let filtered = genres.filter { [id] (genre) -> Bool in
            return genre.id == id
        }
        
        if filtered.count > 0 {
            return filtered[0]
        }
        
        return nil
    }
    
    func getGenres(withIds ids: [Int]) -> [Genre] {
        var genres: [Genre] = []
        
        ids.forEach {
            if let genre = getGenre(withId: $0) {
                genres.append(genre)
            }
        }
        
        return genres
    }

}
