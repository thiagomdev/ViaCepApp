import Foundation
@testable import ViaCep

public enum ShouldBeExpected {
    case success(DataCep)
    case failure(Error)
}

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
