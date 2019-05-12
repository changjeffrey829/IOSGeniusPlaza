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
    func loadMedia(completion: @escaping (Result<[MediaData], MediaLoadingError>) ->())
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, MediaLoadingError>) -> ())
}

struct NetworkService: MediaProtocol {
    
    private let session: DataSessionProtocol
    private var mediaAPI: String
    
    init(mediaType: MediaType, session: DataSessionProtocol = URLSession.shared) {
        self.session = session
        switch mediaType {
        case .movie:
            mediaAPI = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
        case .podCast:
            mediaAPI = "https://rss.itunes.apple.com/api/v1/us/podcasts/top-podcasts/all/10/explicit.json"
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
