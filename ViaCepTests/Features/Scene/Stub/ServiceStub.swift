import Foundation
@testable import ViaCep

final class ServiceStub: MainServicing {
    func getCep(_ cep: String, callback: @escaping (Result<DataCep, Error>) -> Void) {
        callback(.success(.fixture()))
    }
}
