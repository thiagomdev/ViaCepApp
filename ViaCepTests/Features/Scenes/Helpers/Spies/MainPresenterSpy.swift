import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    enum Message: Hashable {
        case presentCep(cep: ViaCep.DataCep)
        case displayError(message: String)
    }
    
    private(set) var messages = Set<Message>()

    private(set) var displayErrorCalled: Bool = false
    private(set) var displayErrorCalledCouting: Int = 0
    
    private(set) var presentCepCalled: Bool = false
    private(set) var presentCepCouting: Int = 0
    
    func presentCep(_ cep: ViaCep.DataCep) {
        presentCepCalled = true
        presentCepCouting += 1
        messages.insert(.presentCep(cep: cep))
    }
    
    func displayError(_ message: String) {
        displayErrorCalled = true
        displayErrorCalledCouting += 1
        self.messages.insert(.displayError(message: message))
    }
}
