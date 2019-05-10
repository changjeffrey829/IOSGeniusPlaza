//
//  MovieViewModel.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/10/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

var imageCache = [String : UIImage]()

class MediaViewModel {
    
    private var lastUrlUsedToLoadImage: String?
    
    private var networkService: NetworkService
    
    private (set) var rawMediaModel: RawMovieData
    
    init(rawMediaModel: RawMovieData, networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        self.rawMediaModel = rawMediaModel
    }
    
    func getImagefromURL(completion: @escaping (Result<UIImage, Error>) -> ()) {
        let urlString = rawMediaModel.artworkUrl100
        lastUrlUsedToLoadImage = urlString
        if let cachedimage = imageCache[urlString] {
            completion(.success(cachedimage))
            return
        }
        networkService.loadImage(urlString: urlString) { (result) in
            completion(result)
        }
    }
}
