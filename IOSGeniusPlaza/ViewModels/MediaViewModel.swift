//
//  MovieViewModel.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/10/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

//MARK:- SIMPLE IMAGE CACHE
var imageCache = [String : UIImage]()

class MediaViewModel {
    
    private var lastUrlUsedToLoadImage: String?
    
    private var networkService: MediaProtocol
    
    private var rawMediaModel: MediaData
    
    init(mediaData: MediaData, networkService: MediaProtocol) {
        self.networkService = networkService
        self.rawMediaModel = mediaData
    }
    
    func getMediaName() -> NSAttributedString {
        let attributedString = getAttributedString(text: rawMediaModel.name)
        return attributedString
    }
    
    func getImagefromURL(completion: @escaping (Result<UIImage, MediaLoadingError>) -> ()) {
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
    
    private func getAttributedString(text: String) -> NSAttributedString {
        let fgColor = UIColor.brown
        if let font = UIFont(name: "MarkerFelt-Wide", size: 16) {
            let attributedString = NSMutableAttributedString(string: rawMediaModel.name, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: fgColor])
            return attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: fgColor])
            return attributedString
        }
    }
}
