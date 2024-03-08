import Foundation
@testable import ViaCep

final class MainServiceSpy: MainServicing {
    var shouldBeExpected: (Result<DataCep, Error>)?

    func fetchDataCep(
        _ cep: String,
        callback: @escaping (Result<DataCep, Error>) -> Void
    ) {
        if let shouldBeExpected {
            callback(shouldBeExpected)
        }
    }
}
