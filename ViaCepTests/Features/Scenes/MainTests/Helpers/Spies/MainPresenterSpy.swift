import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    enum Message: Hashable {
        case presentCep(cep: ViaCep.DataCep)
        case displayError(message: String)
    }
    
    private(set) var messages = [Message]()

    func presentCep(_ cep: ViaCep.DataCep) {
        messages.append(.presentCep(cep: cep))
    }
    
    func displayError(_ message: String) {
        messages.append(.displayError(message: message))
    }
}
