//
//  PopularMoviewViewController.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import UIKit

class PopularMoviesViewController: UIViewController {
    
    var movies: [Movie]?
    var movieRepository: MovieRepository?

    
    
    init(movieRepository: MovieRepository?) {
        self.movieRepository = movieRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(movieRepository: MovieNetworkRepository())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
    }
    
    //MARK: fetch movies
    fileprivate func getMovies() {
        movieRepository?.getPopularMovies {[weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(_):
                break
            }
        }
    }
    
}
