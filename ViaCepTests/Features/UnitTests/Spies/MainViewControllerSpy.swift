import Foundation
@testable import ViaCep

final class MainViewControllerSpy: MainViewControlling {
    enum Message: Hashable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
    }
    
    private(set) var messages = Set<Message>()
    
    private(set) var didPresentCepCalled: Bool = false
    private(set) var didPresentCepCalledCounting: Int = 0
    
    private(set) var didShowErrorCalled: Bool = false
    private(set) var didShowErrorCalledCouting: Int = 0
    
    private(set) var didDisplayInvalidCepMessageCalled: Bool = false
    
    func didPresentCep(_ cep: ViaCep.DataCep) {
        didPresentCepCalled = true
        didPresentCepCalledCounting += 1
        messages.insert(.didShowCep(cep))
    }
    
    func didShowErrorMessage(_ message: String) {
        didShowErrorCalled = true
        didShowErrorCalledCouting += 1
        messages.insert(.didShowError(message))
    }
}
