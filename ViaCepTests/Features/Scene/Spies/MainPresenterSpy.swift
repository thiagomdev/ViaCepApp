import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    enum Message: Hashable {
        case presentCep(_ cep: ViaCep.DataCep)
        case displayError(_ message: String)
        case displayInvalidCepAlertMessage(_ data: ViaCep.DataCep)
        case creatingUser(email: String, password: String)
    }
    
    private(set) var presentCepCalled: Bool = false
    private(set) var messages = Set<Message>()
    private(set) var expected: String?
    
    private(set) var displayInvalidCepAlertMessageCalled: Bool = false
    
    func presentCep(_ cep: ViaCep.DataCep) {
        presentCepCalled = true
        messages.insert(.presentCep(cep))
    }
    
    func displayError(_ message: String) {
        messages.insert(.displayError(message))
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        displayInvalidCepAlertMessageCalled = true
        messages.insert(.displayInvalidCepAlertMessage(data))
    }
    
    func creatingUser(from email: String, password: String) {
        messages.insert(.creatingUser(email: email, password: password))
    }
}
