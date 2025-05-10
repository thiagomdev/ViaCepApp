//
//  MainViewControllerSpy.swift
//  ViaCep
//
//  Created by Thiago Monteiro on 10/05/25.
//

import Foundation
@testable import ViaCep
final class MainViewControllerSpy: MainViewProtocol {
    enum Message: Hashable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
    }
    
    private var message = [(cep: DataCep, error: Error)]()
    
    var responseDataCep: [DataCep] { message.map { $0.cep } }
    var failure: [Error] { message.map { $0.error } }
    
    private(set) var messages = Set<Message>()
    
    private(set) var didPresentCepCalled: Bool = false
    private(set) var didPresentCepCalledCounting: Int = 0
    
    private(set) var didShowErrorCalled: Bool = false
    private(set) var didShowErrorCalledCouting: Int = 0
    
    private(set) var didDisplayInvalidCepMessageCalled: Bool = false
    
    func didPresentCep(_ cep: ViaCep.DataCep) {
        didPresentCepCalled = true
        didPresentCepCalledCounting += 1
        message.append((cep, NSError()))
    }
    
    func didShowErrorMessage(_ message: String) {
        didShowErrorCalled = true
        didShowErrorCalledCouting += 1
        messages.insert(.didShowError(message))
    }
}
