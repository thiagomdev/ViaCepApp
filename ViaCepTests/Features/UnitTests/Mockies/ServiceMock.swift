import Foundation
@testable import ViaCep


public enum HttpResponse {
    case success(DataCep)
    case failure(Error)
}

final class ServiceMock: MainServicing {
    var expexted: HttpResponse?
    
    func fetchDataCep(
        _ cep: String,
        callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void
    ) {
        switch expexted {
        case let .success(dataCep):
            callback(.success(dataCep))
        case let .failure(error):
            callback(.failure(error))
        case nil:
            expexted = nil
        }
    }
}
