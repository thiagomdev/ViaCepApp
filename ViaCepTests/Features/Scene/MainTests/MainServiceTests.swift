import XCTest
@testable import ViaCep

final class MainServiceTests: XCTestCase {
    func test_fetchDataCep() {
        let (sut, serviceSpy, _) = makeSut()
        let dataObject: DataCep = .dummy(cep: "01226-010")
        serviceSpy.shouldBeExpected = .success(.dummy(cep: "01226-010"))
        let expectation = XCTestExpectation(description: "https://viacep.com.br/ws/01226-010/json/")
        
        struct Response: AutoEquatable {
            let mock: (Result<DataCep, Error>)?
        }

        sut.fetchDataCep(dataObject.cep) { result in
            switch result {
            case let .success(data):
                XCTAssertNotNil(data)
                XCTAssertEqual(Response(mock: .success(data)), .init(mock: result))
                XCTAssertEqual(data.cep, dataObject.cep)
                expectation.fulfill()
            case .failure:
                XCTFail("Failure")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_failure() {
        let (sut, serviceSpy, _) = makeSut()
        let dataObject: DataCep = .dummy(cep: "11111-111")
        let failure: NSError = .init(domain: "Test", code: 404)
        serviceSpy.shouldBeExpected = .failure(failure)
        let expectation = XCTestExpectation(description: "https://viacep.com.br/ws/11111-111/json/")
        
        sut.fetchDataCep(dataObject.cep) { result in
            switch result {
            case .success:
                XCTFail("Failure")
            case let .failure(failure):
                XCTAssertNotNil(failure)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
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

final class NetworkingSpy: NetworkingProtocol {
    func execute<T>(request: ViaCep.Request, responseType: T.Type, callback: @escaping (Result<T, Error>) -> Void) -> ViaCep.Task where T : Decodable, T : Encodable {
        Tasking<T>(request: request, callback: callback, responseType: responseType)
    }
}

extension MainServiceTests {
    private func makeSut() -> (
        sut: MainService,
        serviceSpy: MainServiceSpy,
        networkingSpy: NetworkingSpy
    ) {
        let networkingSpy = NetworkingSpy()
        let serviceSpy = MainServiceSpy()
        let sut = MainService(networking: networkingSpy)
        return (sut, serviceSpy, networkingSpy)
    }
}

public protocol AutoEquatable: Equatable { }

public extension AutoEquatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        var lhsDump = String()
        dump(lhs, to: &lhsDump)
        
        var rhsDump = String()
        dump(rhs, to: &rhsDump)
        
        return rhsDump == lhsDump
    }
}
