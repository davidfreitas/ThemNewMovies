//
//  NetworkTests.swift
//  ThemNewMoviesTests
//
//  Created by David Freitas on 15/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import XCTest
@testable import ThemNewMovies

class NetworkTests: XCTestCase {
    
    var httpClient: HttpClient!

    override func setUp() {
        super.setUp()
        httpClient = HttpClient()
    }

    override func tearDown() {
        super.tearDown()
    }

    // -----
    // Tests that a request returns some data
    // -----
    func testRequest() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d") else {
            fatalError("Invalid URL")
        }
        
        let promise = expectation(description: "Simple Request")

        httpClient.request(
            url,
            method: .get,
            parameters: nil,
            headers: nil) {
                (result) in
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    promise.fulfill()
                    break
                case .error(_):
                    fatalError()
                }
                
            }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
