//
//  ExtensionsTests.swift
//  ThemNewMoviesTests
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import XCTest
@testable import ThemNewMovies

class DateElapsedTimeTests: XCTestCase {
    
    func testElapsedTimeToday() {
        // today
        let today = Date()
        let todayString = "today".localized
        
        XCTAssertEqual(today.getElapsedTime(), todayString)
    }

    func testElapsedTimeFuture() {
        // future date
        let future = Date(timeIntervalSinceNow: TimeInterval(3700 * 48))
        let futureString = "\("in".localized) 2 \("days".localized)"
        
        XCTAssertEqual(future.getElapsedTime(), futureString)
    }

    func testElapsedTimePast() {
        // past date
        let past = Date(timeIntervalSinceNow: TimeInterval(3700 * 48 * -1))
        let pastString = "2 \("days".localized) \("ago".localized)"
        
        XCTAssertEqual(past.getElapsedTime(), pastString)
    }
}
