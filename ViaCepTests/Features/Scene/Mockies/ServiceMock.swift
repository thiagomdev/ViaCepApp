import Foundation
@testable import ViaCep

final class ServiceMock: MainServicing {
    var expexted: (Result<ViaCep.DataCep, Error>)?
    
    private(set) var wasCalled: Bool =  false
    private(set) var howManyTimes: Int = 0
    
    func getCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        guard let expexted = expexted else { return }
        wasCalled = true
        howManyTimes += 1
        callback(expexted)
    }
}
