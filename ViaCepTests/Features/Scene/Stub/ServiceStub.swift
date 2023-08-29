import Foundation
@testable import ViaCep

final class ServiceStub: MainServicing {
    func fetchDataCep(_ cep: String, callback: @escaping (Result<DataCep, Error>) -> Void) {
        callback(.success(.dummy()))
    }
}
