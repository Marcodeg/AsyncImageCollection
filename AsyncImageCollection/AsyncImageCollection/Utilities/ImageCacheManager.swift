//
//  ImageCacheManager.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation

class ImageCacheManager {
    static let shared = ImageCacheManager()

    let cache = NSCache<NSString, NSData>()

}
