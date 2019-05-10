//
//  Movie.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit
enum MediaType {
    case movie
    case podCast
}

struct MediaModel {
    let name: String
    let image: UIImage
    let mediaType: MediaType
}

struct Movie {
    let movieName: String
    let publisher: String
    let image: UIImage
    let mediaType: MediaType
}

struct PodCast {
    let name: String
    let image: UIImage
    let mediaType: MediaType
}
