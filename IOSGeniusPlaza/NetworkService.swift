//
//  NetworkService.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

struct NetworkObject: Decodable {
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

struct NetworkService {
    private let session: URLSession
    private let movieAPI = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getMovies(completion: @escaping (Result<[RawMovieData], Error>) -> ()) {
        guard let url = URL(string: movieAPI) else {
            return}
        session.dataTask(with: url) { (data, respnse, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                guard let data = data else {return}
                let networkObjects = try decoder.decode(NetworkObject.self, from: data)
                completion(.success(networkObjects.feed.results))
            } catch let err {
//                let err = SearchError.unableToFindUser
                completion(.failure(err))
            }
        }.resume()
    }
}
