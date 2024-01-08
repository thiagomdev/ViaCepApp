import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    enum Messages: Equatable {
        case presentCep(_ cep: ViaCep.DataCep)
        case displayError(_ message: String)
        case displayInvalidCepAlertMessage(_ data: ViaCep.DataCep)
    }
    
    private(set) var messages: [Messages] = []
    private(set) var expected: String?
    
    private(set) var presentCepCalled: Bool = false
    private(set) var displayInvalidCepAlertMessageCalled: Bool = false
    
    func presentCep(_ cep: ViaCep.DataCep) {
        presentCepCalled = true
        messages.append(.presentCep(cep))
    }
    
    func displayError(_ message: String) {
        messages.append(.displayError(message))
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        displayInvalidCepAlertMessageCalled = true
        messages.append(.displayInvalidCepAlertMessage(data))
    }
    
    func creatingUser(from email: String, password: String) {
        
    }
}
