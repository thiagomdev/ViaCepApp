import XCTest
import ViaCep

final class MainServiceTests: XCTestCase {
    private var dataObject: DataCep = .dummy()
    
    func test_success() {
        let (sut, networkingSpy) = makeSut()
        
        networkingSpy.expected = .success(dataObject)
        
        expect(sut, when: .success(dataObject), then: {
            XCTAssertNotNil(dataObject)
        })
    }
    
    func test_failure_on_non_200_HTTPResponse() {
        let (sut, _) = makeSut()
        let samples = [199, 201, 300, 400, 500].enumerated()
        
        samples.forEach { code in
            let failure: NSError = .init(domain: "error", code: code.element)
            expect(sut, when: .failure(failure), then: {
                XCTAssertNotNil(failure)
            })
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
    
    private func expect(_ sut: MainServicing,
        when dataObject: (Result<DataCep, Error>),
        then action: () ->Void) {
            
        let expectation = expectation(description: "Wait for a completion loading.")
                
        sut.fetchDataCep("01150011") { result in
            switch result {
                case .success:
                XCTAssertNotNil(dataObject)
            case .failure:
                XCTAssertNotNil(dataObject)
            }
            expectation.fulfill()
        }
        
        action()
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertNotNil(dataObject)
    }
}
