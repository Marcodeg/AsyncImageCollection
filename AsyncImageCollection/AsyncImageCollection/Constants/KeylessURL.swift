//
//  KeylessURL.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation

enum KeylessURL {
    case getPopularMovies
    case getPosterImage(posterPath: String)
    
    var url: String {
        let baseUrl = "https://api.themoviedb.org"
        switch self {
        case .getPopularMovies:
            return baseUrl + "/3/movie/popular"
        case .getPosterImage(let posterParh):
            return "https://image.tmdb.org" + "/t/p/w500" + posterParh
        }
    }
}
