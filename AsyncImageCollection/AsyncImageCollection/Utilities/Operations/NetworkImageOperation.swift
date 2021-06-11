//
//  NetworkImageOperation.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import UIKit
import Alamofire

final class NetworkImageOperation: AsyncOperation {
    var image: UIImage?
    
    private let url: URL
    private let completionHandler: ((UIImage?) -> Void)?
    private var task: DataRequest?
    
    init(url: URL, completionHandler: ((UIImage?) -> Void)? = nil) {
        self.url = url
        self.completionHandler = completionHandler
        
        super.init()
    }
    
    convenience init?(string: String, completionHandler: ((UIImage?) -> Void)? = nil) {
        guard let url = URL(string: string) else { return nil }
        self.init(url: url, completionHandler: completionHandler)
    }
    
    override func main() {
        defer { self.state = .finished }
        guard !self.isCancelled else { return }

        let cacheID = NSString(string: self.url.absoluteString)
        if let cachedData = ImageCacheManager.shared.cache.object(forKey: cacheID) {
            self.image = UIImage(data: cachedData as Data)
            self.callCompletionHandler(self.image)
            return
        }
        guard !self.isCancelled else { return }
        task = NetworkManager.shared.session.request(url)
        task?.response { [weak self] (response) in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                ImageCacheManager.shared.cache.setObject(data as NSData, forKey: cacheID)
                self.image = UIImage(data: data)
                self.callCompletionHandler(self.image)
            case .failure(_):
                self.callCompletionHandler(nil)
            }
        }
    }
    
    private func callCompletionHandler(_ image: UIImage?) {
        if let completionHandler = self.completionHandler {
            completionHandler(self.image)
            return
        }
    }
    
    override func cancel() {
        super.cancel()
        task?.cancel()
    }
}

