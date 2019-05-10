//
//  NetworkService.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

struct RawNetworkResponse: Decodable {
    let feed: Feed
}
struct Feed: Decodable {
    let results: [RawMovieData]
}

struct RawMovieData: Decodable {
    let artistName: String
    let name: String
    let artworkUrl100 : String
}

struct NetworkService: MovieDatasource {
    
    private let session: DataSessionProtocol
    private let movieAPI = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    
    init(session: DataSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
//            completion(.failure(SearchError.unableToFindUser))
            return}
        
        session.loadData(from: url) { (data, response, err) in
            if err != nil {
//                completion(.failure(SearchError.unableToFindUser))
                return
            }
            
            guard
                let imageData = data,
                let photoImage = UIImage(data: imageData)
                else {
//                    completion(.failure(SearchError.unableToFindUser))
                    return }
            completion(.success(photoImage))
        }
    }
    
    func loadMovies(completion: @escaping (Result<[RawMovieData], Error>) -> ()) {
        guard let url = URL(string: movieAPI) else {fatalError()}
        
        session.loadData(from: url) { (data, response, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            do {
                let decoder = JSONDecoder()
                guard let data = data else {return}
                let networkObjects = try decoder.decode(RawNetworkResponse.self, from: data)
                completion(.success(networkObjects.feed.results))
            } catch let err {
                completion(.failure(err))
            }
        }
    }
}
