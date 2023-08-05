import Foundation
@testable import ViaCep

final class ViewControllerSpy: MainViewControlling {
    enum Messages: Equatable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
        case didDisplayInvalidCepMessage(_ message: String)
    }
    
    private(set) var messages: [Messages] = []

    func didShowCep(_ cep: ViaCep.DataCep) {
        messages.append(.didShowCep(cep))
    }
    
    func didShowError(_ message: String) {
        messages.append(.didShowError(message))
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        messages.append(.didDisplayInvalidCepMessage(message))
    }
}
