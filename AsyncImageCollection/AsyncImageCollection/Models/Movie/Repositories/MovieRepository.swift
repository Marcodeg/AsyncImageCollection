//
//  MovieRepository.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation

protocol MovieRepository {
    func getPopularMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void)
}
