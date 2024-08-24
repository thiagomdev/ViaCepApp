import Foundation
@testable import ViaCep

final class MainPresenterSpy: MainPresenting {
    var message = Set<DataCep>()

    private(set) var displayErrorCalled: Bool = false
    private(set) var displayErrorCalledCouting: Int = 0
    
    func presentCep(_ cep: ViaCep.DataCep) {
        message.insert(cep)
    }
    
    func displayError(_ message: String) {
        displayErrorCalled = true
        displayErrorCalledCouting += 1
    }
}
