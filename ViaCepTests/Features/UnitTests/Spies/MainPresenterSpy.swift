import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    enum Message: Hashable {
        case presentCep(_ cep: ViaCep.DataCep)
        case displayError(_ message: String)
    }
    
    private(set) var messages = Set<Message>()
    private(set) var presentCepCalled: Bool = false
    private(set) var presentCepCallCounting: Int = 0
    private(set) var expected: String?
        
    func presentCep(_ cep: ViaCep.DataCep) {
        presentCepCalled = true
        presentCepCallCounting += 1
        messages.insert(.presentCep(cep))
    }
    
    func displayError(_ message: String) {
        messages.insert(.displayError(message))
    }
}
