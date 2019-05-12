//
//  IntergrationTests.swift
//  IOSGeniusPlazaTests
//
//  Created by Jeffrey Chang on 5/12/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import IOSGeniusPlaza

class IntergrationTests: XCTestCase {

    func testIntergration() {
        let mockSession = MockSession()
        let networkService = NetworkService(mediaType: .movie, session: mockSession)
        let moviesViewModel = HomeViewModel(mediaService: networkService)
        moviesViewModel.loadMedia { (error) in
            if error != nil {
                XCTFail()
            } else {
                let mediaViewModel = moviesViewModel.mediaViewModelAtIndex(0)
                let movieNameAS = mediaViewModel.getMediaName()
                let font = UIFont(name: "MarkerFelt-Wide", size: 16)!
                let attributedString = NSMutableAttributedString(string: "John Wick - Double Feature", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.brown])
                XCTAssertEqual(attributedString, movieNameAS)
                
            }
        }
    }

}
