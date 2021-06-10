//
//  MovieNetworkRepository.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import Alamofire

struct MovieNetworkRepository: MovieRepository {
    
    enum NetworkError: Error {
        case parsingError
    }
    
    func getPopularMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        let apiKey = "97b8c84cbb519e20571e8852ec5d4696"
        let url = KeylessURL.getPopularMovies.url
        let queryParams: [String: String?] = [
            "api_key": apiKey
        ]
        guard let finalUrl = NetworkManager.getFinalUrlForGetAndDelete(url: url, queryParams: queryParams) else { return }
        NetworkManager.shared.session.request(finalUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<202)
            .responseDecodable(of: NetworkResponse<Movie>.self) { (response) in
                switch response.result {
                case .success(let networkParsedResponse):
                    guard let movies = networkParsedResponse.results else {
                        return completionHandler(.failure(NetworkError.parsingError))
                    }
                    completionHandler(.success(movies))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
