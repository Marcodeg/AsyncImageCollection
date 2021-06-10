//
//  NetworkImageOperationQueueHandler.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation

class NetworkImageOperationQueueHandler: OperationQueueHandler {
    
    var queue: OperationQueue? = OperationQueue()
    var operations: [IndexPath : NetworkImageOperation] = [:]
    
    typealias T = NetworkImageOperation
}
