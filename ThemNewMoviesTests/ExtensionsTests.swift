//
//  ExtensionsTests.swift
//  ThemNewMoviesTests
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import XCTest
@testable import ThemNewMovies

class ExtensionsTests: XCTestCase {

    func testElapsedTime() {
        // future date
        let future = Date(timeIntervalSinceNow: TimeInterval(3700 * 48))
        let futureString = "\(NSLocalizedString("in", comment: "")) 2 \(NSLocalizedString("days", comment: ""))"
        XCTAssertEqual(future.getElapsedTime(), futureString)
        
        // past date
        let past = Date(timeIntervalSinceNow: TimeInterval(3700 * 48 * -1))
        let pastString = "2 \(NSLocalizedString("days", comment: "")) \(NSLocalizedString("ago", comment: ""))"
        XCTAssertEqual(past.getElapsedTime(), pastString)
        
        // today
        let todayString = NSLocalizedString("today", comment: "")
        XCTAssertEqual(Date().getElapsedTime(), todayString)
    }

}
