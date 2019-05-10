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
    
    func testGetMovies() {
        let mock = MockSession()
        let sut = NetworkService(session: mock)
        sut.getMovies { (result) in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let movies):
                XCTAssertEqual(10, movies.count)
            }
        }
    }
}
