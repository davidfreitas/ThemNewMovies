//
//  GenreCollectionViewCell.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: GenreViewModel!
    
    override func awakeFromNib() {
    }
    
    func setViewModel(_ viewModel: GenreViewModel) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.name
    }
}
