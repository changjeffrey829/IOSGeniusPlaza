//
//  ViewModel.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

protocol MovieDatasource {
    func loadMovies(completion: @escaping (Result<[RawMovieData], Error>) ->())
    func loadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

class HomeViewModel {
    private let movieDatasource: MovieDatasource
    private var movies = [RawMovieData]()
    static let cellID = "cellID"
    init(movieLoadable: MovieDatasource = NetworkService()) {
        self.movieDatasource = movieLoadable
    }
    
    func loadMovies(completion: @escaping (Error?) -> ()) {
        movieDatasource.loadMovies { [unowned self] (result) in
            switch result {
            case .failure(let err):
                completion(err)
            case .success(let rawMovieData):
                self.movies = rawMovieData
                
//                let movies = rawMovieData.map({ (rawData) -> MediaModel in
//                    self.movieDatasource.loadImage(urlString: rawData.artworkUrl100, completion: { (result) in
//                        var movieImage: UIImage
//                        switch result {
//                        case .failure(_):
//                            movieImage = #imageLiteral(resourceName: "smashBall.svg")
//                        case .success(let image):
//                            movieImage = image
//                        }
//                    })
//                    return MediaModel(name: rawData.name, image: movieImage, mediaType: .movie)
//                })
                completion(nil)
            }
        }
    }
    
    func moviesCount() -> Int {
        return movies.count
    }
    
    func MediaViewModelAtIndex(_ index: Int) -> MediaViewModel {
        return MediaViewModel(rawMediaModel: movies[index])
    }
    
    func movieAtIndex(_ index: Int) -> RawMovieData {
        return movies[index]
    }
}
