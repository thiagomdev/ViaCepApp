import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    enum Message: Hashable {
        case presentCep(_ cep: ViaCep.DataCep)
        case displayError(_ message: String)
        case displayInvalidCepAlertMessage(_ data: ViaCep.DataCep)
    }
    
    private(set) var messages = Set<Message>()
    private(set) var presentCepCalled: Bool = false
    private(set) var expected: String?
    
    private(set) var displayInvalidCepAlertMessageCalled: Bool = false
    private(set) var displayInvalidCepAlertMessageCounting: Int = 0
    
    func presentCep(_ cep: ViaCep.DataCep) {
        presentCepCalled = true
        messages.insert(.presentCep(cep))
    }
    
    func displayError(_ message: String) {
        messages.insert(.displayError(message))
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        displayInvalidCepAlertMessageCalled = true
        displayInvalidCepAlertMessageCounting += 1
        messages.insert(.displayInvalidCepAlertMessage(data))
    }
}
