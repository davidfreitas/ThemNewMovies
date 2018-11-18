//
//  MovieDetailsViewController.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateHeaderLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var genresCollectionViewLayout: UICollectionViewFlowLayout!
    
    private let genresCollectionViewHandler = GenreCollectionViewHandler()
    
    var viewModel: MovieViewModel!
    
    class func instanceFromStoryboard() -> MovieDetailsViewController? {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as? MovieDetailsViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "movie".localized

        setupGenresCollectionView()
        setMovieInfo()
        loadImages()
    }
    
    private func setupGenresCollectionView() {
        genresCollectionView.dataSource = genresCollectionViewHandler
        genresCollectionView.delegate = genresCollectionViewHandler
        genresCollectionViewLayout.estimatedItemSize = CGSize(width: 100, height: 20)
        genresCollectionViewLayout.minimumInteritemSpacing = 4
        
        // set genres
        let genresViewModel = GenreListViewModel(genres: viewModel.genres)
        genresCollectionViewHandler.viewModel = genresViewModel
    }
    
    private func setMovieInfo() {
        titleLabel.text = "\(viewModel.title) (\(viewModel.releaseYear))"
        overviewLabel.text = viewModel.overview
        releaseDateHeaderLabel.text = "releaseDate".localized
        releaseDateLabel.text = viewModel.releaseDate
        elapsedTimeLabel.text = viewModel.releaseTimeFromNow
    }
    
    private func loadImages() {
        if let posterURL = viewModel.posterURL(forSize: .w154) {
            posterImageView.af_setImage(withURL: posterURL)
        } else {
            posterImageView.removeFromSuperview()
        }
        
        if let backdropURL = viewModel.backdropURL(forSize: .w300) {
            backdropImageView.af_setImage(withURL: backdropURL)
        }
    }

}
