import Foundation
@testable import ViaCep

final class ServiceMock: MainServicing {
    var expexted: [(Result<ViaCep.DataCep, Error>) -> Void] = []
    
    func fetchDataCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        expexted.append(callback)
    }
}
