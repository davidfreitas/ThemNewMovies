//
//  String+Localized.swift
//  ThemNewMovies
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

}
