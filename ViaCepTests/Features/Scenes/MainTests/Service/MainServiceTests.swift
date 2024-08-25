import XCTest
import ViaCep

final class MainServiceTests: XCTestCase {
    private var dataObject: DataCep = .dummy()
    
    func test_success() {
        let (sut, networkingSpy) = makeSut()
        
        networkingSpy.expected = .success(dataObject)
        
        expect(sut, toCompleteWithDataObject: .success(dataObject)) {
            XCTAssertNotNil(dataObject)
        }
    }
    
    func test_failure() {
        let (sut, _) = makeSut()
        let failure: NSError = .init(domain: "error", code: 400)
        
        expect(sut, toCompleteWithDataObject: .failure(failure)) {
            XCTAssertNotNil(failure)
        }
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
    
    private func expect(
        _ sut: MainServicing,
        toCompleteWithDataObject data: (Result<DataCep, Error>),
        when action: () ->Void) {
            
        let expectation = expectation(description: "Wait for a completion loading.")
                
        sut.fetchDataCep("01150011") { result in
            switch result {
                case .success:
                XCTAssertNotNil(data)
            case .failure:
                XCTAssertNotNil(data)
            }
            expectation.fulfill()
        }
        
        action()
        
        wait(for: [expectation], timeout: 3.0)
    }
}
