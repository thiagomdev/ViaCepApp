import Foundation
@testable import ViaCep

final class InteractorSpy: MainPresenting {
    enum Messages: Equatable {
        case presentCep(_ cep: ViaCep.DataCep)
        case displayError(_ message: String)
        case displayInvalidCepAlertMessage(_ data: ViaCep.DataCep)
    }
    
    private(set) var messages: [Messages] = []
    private(set) var expected: String?
        
    func presentCep(_ cep: ViaCep.DataCep) {
        messages.append(.presentCep(cep))
    }
    
    func displayError(_ message: String) {
        messages.append(.displayError(message))
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        messages.append(.displayInvalidCepAlertMessage(data))
    }
}
