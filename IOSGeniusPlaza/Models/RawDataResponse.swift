//
//  RawDataResponse.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/12/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

struct RawNetworkResponse: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [MediaData]
}
