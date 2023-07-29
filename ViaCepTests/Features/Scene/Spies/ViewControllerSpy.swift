import Foundation
@testable import ViaCep

final class ViewControllerSpy: MainViewControlling {

    private(set) var wasCalled: Bool = false
    private(set) var errorMessage: String?
    private(set) var howManyTimes: Int = 0
    var expected: DataCep?
    
    func didShowCep(_ cep: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        expected = cep
    }
    
    func didShowError(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        errorMessage = message
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        errorMessage = message
    }
}
