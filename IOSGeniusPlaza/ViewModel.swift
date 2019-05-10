//
//  ViewModel.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class ViewModel {
    private let networkService: NetworkService
    
    private var movies = [RawMovieData]()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadMovies(completion: @escaping (Error?) -> ()) {
        networkService.getMovies { [unowned self] (result) in
            switch result {
            case .failure(let err):
                completion(err)
            case .success(let movies):
                self.movies = movies
                completion(nil)
            }
        }
    }
    
    func moviesCount() -> Int {
        return movies.count
    }
    
    func movieAtIndex(_ index: Int) -> RawMovieData {
        return movies[index]
    }
}
