//
//  UpcomingMoviesTableViewController.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class UpcomingMoviesTableViewController: UITableViewController {
    
    private let cellIdentifier = "MovieCell"
    private let loaderCellIdentifier = "LoaderCell"

    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: UpcomingMoviesViewModel!
    private var searchViewModel: SearchMoviesViewModel!
    
    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isSearching: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "upcomingMovies".localized
        
        setupSearchController()
        setupRefreshControl()
        setupViewModel()
        setupSearchViewModel()
        
        GenreManager.shared.loadGenres { [weak self] in
            self?.viewModel.refresh()
        }
    }
    
    private func setupViewModel() {
        LoaderView.show()
        
        viewModel = UpcomingMoviesViewModel()
        viewModel.updatedMovies = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
            LoaderView.hide()
        }
    }
    
    private func setupSearchViewModel() {
        searchViewModel = SearchMoviesViewModel()
        searchViewModel.updatedMovies = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
            LoaderView.hide()
        }
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "searchMovies".localized
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        viewModel.refresh()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchViewModel.hasNextPage ? searchViewModel.count + 1 : searchViewModel.count
        }
        
        return viewModel.hasNextPage ? viewModel.count + 1 : viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (isSearching && indexPath.row < searchViewModel.count)
            || (!isSearching && indexPath.row < viewModel.count) {
            return movieCell(atIndexPath: indexPath)
        }
        
        return loaderCell(atIndexPath: indexPath)
    }
    
    // -----
    // Get a MovieTableViewCell
    // -----
    private func movieCell(atIndexPath indexPath: IndexPath) -> MovieTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
        
        let movieViewModel: MovieViewModel!
        if isSearching {
            movieViewModel = searchViewModel.getMovieViewModel(index: indexPath.row)
        } else {
            movieViewModel = viewModel.getMovieViewModel(index: indexPath.row)
        }
        
        cell.setViewModel(movieViewModel)
        
        return cell
    }
    
    // -----
    // Get the loader cell
    // -----
    private func loaderCell(atIndexPath indexPath: IndexPath) -> LoaderTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: loaderCellIdentifier, for: indexPath) as! LoaderTableViewCell
        
        cell.startAnimating()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isSearching && indexPath.row == searchViewModel.count {
            searchViewModel.loadNextPage()
        } else if !isSearching && indexPath.row == viewModel.count {
            viewModel.loadNextPage()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show movie details
        if let detailViewController = MovieDetailsViewController.instanceFromStoryboard() {
            let movieViewModel: MovieViewModel!
            
            if isSearching {
                movieViewModel = searchViewModel.getMovieViewModel(index: indexPath.row)
            } else {
                movieViewModel = viewModel.getMovieViewModel(index: indexPath.row)
            }
            
            detailViewController.viewModel = movieViewModel
            
            self.navigationController?.pushViewController(
                detailViewController,
                animated: true)
        }
    }
    
    // MARK: - User interactions
    
    @IBAction func searchButtonAction(_ sender: Any) {
        searchController.isActive = true
    }
    
}

extension UpcomingMoviesTableViewController: UISearchBarDelegate {
    // -----
    // Search bar delegate
    // -----
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchController.searchBar.text else {
            return
        }
        
        LoaderView.show()
        searchViewModel.setQuery(query: query)
        searchViewModel.refresh()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        tableView.reloadData()
    }
    
}
