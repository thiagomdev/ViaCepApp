import Foundation
@testable import ViaCep

final class MainViewControllerSpy: MainViewControlling {
    enum Messages: Equatable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
        case didDisplayInvalidCepMessage(_ message: String)
    }
    
    private(set) var messages: [Messages] = []
    private(set) var didPresentCepCalled: Bool = false
    private(set) var didShowErrorCalled: Bool = false
    private(set) var didDisplayInvalidCepMessageCalled: Bool = false
    
    func didPresentCep(_ cep: ViaCep.DataCep) {
        didPresentCepCalled = true
        messages.append(.didShowCep(cep))
    }
    
    func didShowErrorMessage(_ message: String) {
        didShowErrorCalled = true
        messages.append(.didShowError(message))
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        didDisplayInvalidCepMessageCalled = true
        messages.append(.didDisplayInvalidCepMessage(message))
    }
    
    func didCreateUser(from email: String, password: String) {
        
    }
}
