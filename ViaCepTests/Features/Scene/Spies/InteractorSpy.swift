import Foundation
@testable import ViaCep

final class InteractorSpy: MainPresenting {
    
    private(set) var expected: String?
    private(set) var dataModelExpected: DataCep?
    private(set) var wasCalled: Bool =  false
    private(set) var howManyTimes: Int = 0
        
    func presentCep(_ cep: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        expected = cep.cep
    }
    
    func displayError(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        expected = message
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        dataModelExpected = data
    }
}
