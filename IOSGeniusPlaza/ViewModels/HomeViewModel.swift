//
//  ViewModel.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class HomeViewModel {
    private let mediaService: MediaProtocol
    private var mediaObjects = [MediaData]()
    static let cellID = "cellID"
    static let headerHeight: CGFloat = 100
    static let cellHeight: CGFloat = 100
    
    init(mediaService: MediaProtocol) {
        self.mediaService = mediaService
    }
    
    func loadMedia(completion: @escaping (MediaLoadingError?) -> ()) {
        mediaService.loadMedia { [unowned self] (result) in
            switch result {
            case .failure(let err):
                completion(err)
            case .success(let rawMovieData):
                self.mediaObjects = rawMovieData
                completion(nil)
            }
        }
    }
    
    func mediaCount() -> Int {
        return mediaObjects.count
    }
    
    func mediaViewModelAtIndex(_ index: Int) -> MediaViewModel {
        return MediaViewModel(mediaType: mediaService.mediaType, mediaData: mediaObjects[index], networkService: mediaService)
    }
}
