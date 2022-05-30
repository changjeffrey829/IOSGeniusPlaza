//
//  NetworkService.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

enum MediaLoadingError: Error {
    case imageError
    case mediaError
}

protocol MediaProtocol {
    var mediaType: MediaType {get}
    func loadMedia(completion: @escaping (Result<[MediaData], MediaLoadingError>) ->())
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, MediaLoadingError>) -> ())
}

struct NetworkService: MediaProtocol {
    
    private let session: DataSessionProtocol
    private var mediaAPI: String
    private (set) var mediaType: MediaType
    
    init(mediaType: MediaType, session: DataSessionProtocol = URLSession.shared) {
        self.session = session
        self.mediaType = mediaType
        switch mediaType {
        case .app:
            mediaAPI = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/10/apps.json"
        case .podCast:
            mediaAPI = "https://rss.applemarketingtools.com/api/v2/us/podcasts/top/10/podcasts.json"
        }
    }
    
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, MediaLoadingError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(MediaLoadingError.imageError))
            return}
        
        session.loadData(from: url) { (data, response, err) in
            if err != nil {
                completion(.failure(MediaLoadingError.imageError))
                return
            }
            
            guard
                let imageData = data,
                let photoImage = UIImage(data: imageData)
                else {
                    completion(.failure(MediaLoadingError.imageError))
                    return }
            completion(.success(photoImage))
        }
    }
    
    func loadMedia(completion: @escaping (Result<[MediaData], MediaLoadingError>) -> ()) {
        
        guard let url = URL(string: mediaAPI) else {
            completion(.failure(MediaLoadingError.mediaError))
            return
        }
        
        session.loadData(from: url) { (data, response, err) in
            if err != nil {
                completion(.failure(MediaLoadingError.mediaError))
                return
            }
            do {
                let decoder = JSONDecoder()
                guard let data = data else {return}
                let rawNetworkResponse = try decoder.decode(RawNetworkResponse.self, from: data)
                completion(.success(rawNetworkResponse.feed.results))
            } catch {
                completion(.failure(MediaLoadingError.mediaError))
            }
        }
    }
}
