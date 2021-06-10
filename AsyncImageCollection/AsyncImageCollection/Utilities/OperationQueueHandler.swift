//
//  OperationQueueHandler.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation

protocol OperationQueueHandler {
    associatedtype T: Operation
    var queue: OperationQueue? {get set}
    var operations: [IndexPath: T] {get set}
    
    mutating func addOperationToQueue(_ operation: T, _ indexPath: IndexPath)
    func cancelExistingOperation(_ indexPath: IndexPath)
}

extension OperationQueueHandler {
    
    func cancelExistingOperation(_ indexPath: IndexPath) {
        if let existingOperation = operations[indexPath] {
            existingOperation.cancel()
        }
    }
    
    mutating func addOperationToQueue(_ operation: T, _ indexPath: IndexPath) {
        queue?.addOperation(operation)
        cancelExistingOperation(indexPath)
        operations[indexPath] = operation
    }
}
