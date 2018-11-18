//
//  GenreCollectionViewHandler.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class GenreCollectionViewHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellIdentifier = "GenreCell"
    
    var viewModel: GenreListViewModel!
    
    override init() {
        self.viewModel = GenreListViewModel(genres: [])
    }
    
    // MARK: - Collection view data source and delegate methos
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GenreCollectionViewCell
        
        let genreViewModel = viewModel.getGenreViewModel(index: indexPath.row)
        cell.setViewModel(genreViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
