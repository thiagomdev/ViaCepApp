import Foundation
@testable import ViaCep

final class ServiceMock: MainServicing {
    var expexted: (Result<ViaCep.DataCep, Error>)?
    
    private(set) var getCepWasCalled: Bool =  false
    private(set) var getCepCounter: Int = 0
    
    func getCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        guard let expexted = expexted else { return }
        getCepWasCalled = true
        getCepCounter += 1
        callback(expexted)
    }
}
