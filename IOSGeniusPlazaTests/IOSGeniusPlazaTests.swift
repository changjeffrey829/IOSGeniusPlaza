//
//  IOSGeniusPlazaTests.swift
//  IOSGeniusPlazaTests
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import IOSGeniusPlaza

class IOSGeniusPlazaTests: XCTestCase {
    
    var sut: NetworkService?
    
    func testGetMovieFromServer() {
        //In a TableView, display the name, image and media type of the iTunes media.
        let expectation = XCTestExpectation(description: "wait at least 2 to second reach backend for movies")
        sut?.getMovies(completion: { (result) in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let movies):
                XCTAssertEqual(10, movies.count)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
    }
    

    override func setUp() {
        sut = NetworkService()
    }

    override func tearDown() {
        sut = nil
    }

}
