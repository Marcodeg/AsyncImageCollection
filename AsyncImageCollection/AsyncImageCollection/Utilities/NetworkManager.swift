//
//  NetworkManager.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {

    private override init(){}

    static let shared = NetworkManager()

    lazy var policyManager: ServerTrustManager = {
        let trustPolicy = PinnedCertificatesTrustEvaluator(certificates: Bundle.main.af.certificates, acceptSelfSignedCertificates: false, performDefaultValidation: true, validateHost: true)
        
        let trustPolicies = [:] as [String : ServerTrustEvaluating]
        return ServerTrustManager(evaluators: trustPolicies)
    }()

    /// - Returns: SessionManager
    lazy var session: Alamofire.Session = {
        return Alamofire.Session(configuration: .default)
        
    }()
    
    static func getFinalUrlForGetAndDelete(url: String, queryParams: [String: String?]?) -> URL? {
        guard var queryParams = queryParams else { return URL(string: url) }
        
        queryParams = queryParams.filter({ return  $1 != nil })
        
        var urlComponent = URLComponents(string: url)!
        let queryItems = queryParams.map{URLQueryItem(name: $0.key, value: $0.value)}
        urlComponent.queryItems = queryItems
        
        return urlComponent.url
    }
}
