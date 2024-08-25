import Foundation
@testable import ViaCep

public enum ShouldBeExpected {
    case success(DataCep)
    case failure(Error)
}

final class MainServiceSpy: MainServicing {
    var shouldBeExpected: (DataCepResponse)?

    private(set) var fetchDataCepCalled: Bool = false
    private(set) var fetchDataCepCalledCounting: Int = 0
    
    func fetchDataCep(
        _ cep: String,
        callback: @escaping (DataCepResponse) -> Void
    ) {
        fetchDataCepCalled = true
        fetchDataCepCalledCounting += 1
        if let shouldBeExpected {
            callback(shouldBeExpected)
        }
    }
}
