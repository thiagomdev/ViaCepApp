//
//  MemoryLeakTracker.swift
//  ViaCep
//
//  Created by Thiago Monteiro on 10/05/25.
//

import Testing

struct MemoryLeakTracker<T: AnyObject> {
    weak var object: T?
    var sourceLocation: SourceLocation
    
    func verify() {
        #expect(
            object == nil,
            "Expected \(object) to be deallocated. Potential memory leak",
            sourceLocation: sourceLocation
        )
    }
}
