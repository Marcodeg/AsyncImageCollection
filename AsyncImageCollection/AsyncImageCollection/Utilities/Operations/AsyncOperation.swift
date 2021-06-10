//
//  AsyncOperation.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation

class AsyncOperation: Operation {
  // Create state management
  enum State: String {
    case ready
    case executing
    case finished

    fileprivate var keyPath: String {
      return "is\(rawValue.capitalized)"
    }
  }

  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }

  // Override properties
  override var isReady: Bool {
    return super.isReady && state == .ready
  }

  override var isExecuting: Bool {
    return state == .executing
  }

  override var isFinished: Bool {
    return state == .finished
  }

  override var isAsynchronous: Bool {
    return true
  }

  // Override start
  override func start() {
    if isCancelled {
        state = .finished
        return
    }
    
    main()
    state = .executing
  }
}
