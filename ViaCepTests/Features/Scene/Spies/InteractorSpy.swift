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
    private(set) var dataModelExpected: DataCep?
        
    func presentCep(_ cep: ViaCep.DataCep) {
        messages.append(.presentCep(cep))
    }
    
    private(set) var displayErrorIsCalled: Bool = false
    func displayError(_ message: String) {
        messages.append(.displayError(message))
    }
    
    private(set) var displayInvalidCepAlertMessageIsCalled: Bool = false
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        messages.append(.displayInvalidCepAlertMessage(data))
    }
}
