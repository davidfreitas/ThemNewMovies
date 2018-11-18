//
//  MovieTableViewCell.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var genresCollectionViewLayout: UICollectionViewFlowLayout!
    
    private var viewModel: MovieViewModel!
    private let genresCollectionViewHandler = GenreCollectionViewHandler()
    
    override func awakeFromNib() {
        setupGenresCollectionView()
    }
    
    private func setupGenresCollectionView() {
        genresCollectionView.dataSource = genresCollectionViewHandler
        genresCollectionView.delegate = genresCollectionViewHandler
        genresCollectionViewLayout.estimatedItemSize = CGSize(width: 100, height: 20)
        genresCollectionViewLayout.minimumInteritemSpacing = 4
    }
    
    func setViewModel(_ viewModel: MovieViewModel) {
        self.viewModel = viewModel
        
        // set label texts
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        
        // set poster image
        loadPoster()
        
        // set genres
        let genresViewModel = GenreListViewModel(genres: viewModel.genres)
        genresCollectionViewHandler.viewModel = genresViewModel
        genresCollectionView.reloadData()
    }
    
    func loadPoster() {
        posterImageView.image = nil
        
        let imageURL: URL!
        if let posterURL = viewModel.posterURL(forSize: .w154) {
            imageURL = posterURL
        } else if let backdropURL = viewModel.backdropURL(forSize: .w300) {
            imageURL = backdropURL
        } else {
            return
        }
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        posterImageView.af_setImage(
            withURL: imageURL,
            placeholderImage: nil,
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: .crossDissolve(0.25),
            runImageTransitionIfCached: false) { [weak self] (_) in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
        }
    }
    
}
