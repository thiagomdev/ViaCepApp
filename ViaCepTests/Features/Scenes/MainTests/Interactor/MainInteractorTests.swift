import XCTest
import ViaCep

final class MainInteractorTests: XCTestCase {
    private let dataObject: DataCep = .dummy()
    
    func test_display_cep_success() {
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expectedResponse = .success(.dummy())
        
        sut.displayCep(dataObject.cep)

        XCTAssertEqual(doubles.presenterSpy.message, [.dummy()])
    }
    
    func test_display_cep_failure() {
        let (sut, doubles) = makeSut()
        let samples = [199, 201, 300, 400, 500].enumerated()
        
        samples.forEach { index, code in
            let err = NSError(domain: "Wainting for a conclusion of the request", code: code)
            
            doubles.serviceSpy.expectedResponse = .failure(err)
            doubles.presenterSpy.message = [.dummy()]
            
            sut.displayCep(dataObject.cep)
            
            XCTAssertFalse(doubles.presenterSpy.message.isEmpty)
            XCTAssertEqual(doubles.presenterSpy.message, [.dummy()])
        }
    }
}

extension MainInteractorTests {
    // MARK: - Helpers
    typealias Doubles = (
        presenterSpy: MainPresenterSpy,
        serviceSpy: ServiceMock
    )

    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainInteractor,
        doubles: Doubles) {
        
        let serviceSpy = ServiceMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
    
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: presenterSpy, file: file, line: line)
        trackForMemoryLeaks(to: serviceSpy, file: file, line: line)
        
        return (sut, (presenterSpy, serviceSpy))
    }
    
    public enum FetchDataResult {
        case success(DataCep)
        case failure(Error)
    }
    
    final class ServiceMock: MainServicing {
        private var messages = [(cep: String, callback: (FetchDataResult) -> Void)]()
        
        var expectedResponse: (FetchDataResult)?
                
        func fetchDataCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
            if let expectedResponse {
                switch expectedResponse {
                case .success(let success):
                    callback(.success(success))
                case .failure(let failure):
                    callback(.failure(failure))
                }
            }
        }
    }
}
