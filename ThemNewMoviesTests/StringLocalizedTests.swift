//
//  StringLocalizedTests.swift
//  ThemNewMoviesTests
//
//  Created by David Freitas on 17/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import XCTest
@testable import ThemNewMovies

class StringLocalizedTests: XCTestCase {

    func testLocalizedString() {
        let localizedString = NSLocalizedString("today", comment: "")
        
        XCTAssertEqual(localizedString, "today".localized)
    }

}
