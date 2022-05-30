//
//  IOSGeniusPlazaTests.swift
//  IOSGeniusPlazaTests
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import IOSGeniusPlaza

class UnitTesting: XCTestCase {
    
    func testLoadMediaFromServer() {
        let mock = MockSession()
        let sut = NetworkService(mediaType: .app, session: mock)
        sut.loadMedia { (result) in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let movies):
                XCTAssertEqual(10, movies.count)
            }
        }
    }
    
    func testErrorLoadMediaFromServer() {
        let mock = MockErrorSession()
        let sut = NetworkService(mediaType: .app, session: mock)
        sut.loadMedia { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, MediaLoadingError.mediaError)
            case .success(_):
                XCTFail()
            }
        }
    }
    
}
