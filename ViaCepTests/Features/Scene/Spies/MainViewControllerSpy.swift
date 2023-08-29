import Foundation
@testable import ViaCep

final class MainViewControllerSpy: MainViewControlling {
    enum Messages: Equatable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
        case didDisplayInvalidCepMessage(_ message: String)
    }
    
    private(set) var messages: [Messages] = []

    func didPresentCep(_ cep: ViaCep.DataCep) {
        messages.append(.didShowCep(cep))
    }
    
    func didShowErrorMessage(_ message: String) {
        messages.append(.didShowError(message))
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        messages.append(.didDisplayInvalidCepMessage(message))
    }
}
