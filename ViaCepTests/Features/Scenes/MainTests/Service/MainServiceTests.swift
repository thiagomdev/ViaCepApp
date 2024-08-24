import XCTest
import ViaCep

final class MainServiceTests: XCTestCase {
    func test_success() {
        let (sut, networkingSpy) = makeSut()
        var expResult: DataCep?
        let exp = expectation(description: "Wait for a completion loading.")
        
        networkingSpy.expected = .success(.dummy())
        
        sut.fetchDataCep("") { result in
            if case .success(let dataObject) = result {
                expResult = dataObject
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertNotNil(expResult)
    }
    
    func test_failure() {
        let (sut, networkingSpy) = makeSut()
        var expError: Error?
        let exp = expectation(description: "Wait for a completion loading.")
        let failure: NSError = .init(domain: "error", code: 400)
        
        networkingSpy.expected = .failure(failure)

        sut.fetchDataCep("01150011") { result in
            if case .failure(let error) = result {
                expError = error
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertNotNil(expError)
    }
}

extension MainServiceTests {
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainServicing,
        networkingSpy: NetworkingSpy) {
            
        let networkingSpy = NetworkingSpy()
        let sut = MainService(networking: networkingSpy)
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: networkingSpy, file: file, line: line)
        
        return (sut, networkingSpy)
    }
    
    private final class NetworkingSpy: NetworkingProtocol {        
        var expected: (Result<DataCep, Error>) = .failure(NetworkingError.unknown)
        
        func execute<T>(
            request: ViaCep.Request,
            responseType: T.Type,
            callback: @escaping (Result<T, Error>
            ) -> Void) -> ViaCep.Task where T : Decodable, T : Encodable {
            callback(expected as! Result<T, Error>)
            return TaskDummy()
        }
    }
}
