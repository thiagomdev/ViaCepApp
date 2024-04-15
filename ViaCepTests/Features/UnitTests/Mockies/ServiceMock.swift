import Foundation
@testable import ViaCep


public enum HttpResponseMock {
    case success(DataCep)
    case failure(Error)
}

final class ServiceMock: MainServicing {
    var expexted: HttpResponseMock = .success(.dummy())
    
    private (set) var fetchDataCepCalled: Bool = false
    private (set) var fetchDataCepCalledCounting: Int = 0
    
    func fetchDataCep(
        _ cep: String,
        callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        
        fetchDataCepCalled = true
        fetchDataCepCalledCounting += 1
        
        switch expexted {
        case let .success(dataCep):
            callback(.success(dataCep))
        case let .failure(error):
            callback(.failure(error))
        }
    }
}
