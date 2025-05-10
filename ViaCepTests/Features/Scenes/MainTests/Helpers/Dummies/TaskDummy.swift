//
//  TaskDummy.swift
//  ViaCep
//
//  Created by Thiago Monteiro on 08/02/25.
//
import Foundation
@testable import ViaCep

final class TaskDummy: Task {
    var request: ViaCep.Request = RequestDummy()
    
    func resume() {}
    
    func cancel() {}
}
