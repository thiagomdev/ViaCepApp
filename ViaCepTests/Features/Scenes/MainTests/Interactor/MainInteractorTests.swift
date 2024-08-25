import XCTest
import ViaCep

final class MainInteractorTests: XCTestCase {
    private let dataObject: DataCep = .dummy()
    
    func test_display_cep_success() {
        let (sut, doubles) = makeSut()
        
        doubles.serviceSpy.expectedResponse = .success(.dummy())
        
        expect(sut, onCompleteWith: .success(.dummy())) {
            XCTAssertEqual(doubles.presenterSpy.message, [.dummy()])
        }
    }
    
    func test_display_cep_failure() {
        let (sut, doubles) = makeSut()
        let samples = [199, 201, 300, 400, 500].enumerated()
        let err = NSError(domain: "Wainting for a conclusion of the request", code: samples.underestimatedCount)
        doubles.serviceSpy.expectedResponse = .failure(err)
        doubles.presenterSpy.message = [.dummy()]

        samples.forEach { _, _ in
            expect(sut, onCompleteWith: .failure(err)) {
                XCTAssertFalse(doubles.presenterSpy.message.isEmpty)
                XCTAssertEqual(doubles.presenterSpy.message, [.dummy()])
            }
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
    
    private func expect(
        _ sut: MainInteractor,
        onCompleteWith result: FetchDataResult,
        when action: () -> Void) {
            
        let expectation = expectation(description: "Wait for a completion loading.")
            
        sut.displayCep("01150011")
       
        switch result {
        case let .success(dataCep):
            XCTAssertNotNil(dataCep)
        case let .failure(error):
            XCTAssertNotNil(error)
        }
        
        expectation.fulfill()
            
        action()

        wait(for: [expectation], timeout: 3.0)
    }
}
