import Foundation
@testable import ViaCep

final class ServiceMock: MainServicing {
    var expexted: (Result<ViaCep.DataCep, Error>)?
    
    func fetchDataCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        if let expexted {
            callback(expexted)
        }
    }
}
