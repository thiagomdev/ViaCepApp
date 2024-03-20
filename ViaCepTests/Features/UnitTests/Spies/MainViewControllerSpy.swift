import Foundation
@testable import ViaCep

final class MainViewControllerSpy: MainViewControlling {
    enum Message: Hashable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
    }
    
    private(set) var messages = Set<Message>()
    private(set) var didPresentCepCalled: Bool = false
    private(set) var didShowErrorCalled: Bool = false
    private(set) var didDisplayInvalidCepMessageCalled: Bool = false
    
    func didPresentCep(_ cep: ViaCep.DataCep) {
        didPresentCepCalled = true
        messages.insert(.didShowCep(cep))
    }
    
    func didShowErrorMessage(_ message: String) {
        didShowErrorCalled = true
        messages.insert(.didShowError(message))
    }
}
