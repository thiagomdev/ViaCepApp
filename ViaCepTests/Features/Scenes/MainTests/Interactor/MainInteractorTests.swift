import Foundation
import ViaCep
import Testing

private struct MainInteractorTests {
    @Test
    func display_cep_success() {
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expectedResponse = .success(.dummy())
        sut.displayCep("01150011")
        #expect(doubles.presenterSpy.message == [.dummy()])
    }
    
    @Test
    func test_display_cep_failure() {
        let (sut, doubles) = makeSut()
        let samples = [199, 201, 300, 400, 500].enumerated()
        let err = NSError(
            domain: "Wainting for a conclusion of the request",
            code: samples.underestimatedCount
        )
        doubles.presenterSpy.message = [.dummy()]
        doubles.serviceSpy.expectedResponse = .failure(err)
        sut.displayCep("01150011")
      
        samples.forEach { _, _ in
            #expect(doubles.presenterSpy.message.isEmpty == false)
            #expect(doubles.presenterSpy.message == [.dummy()])
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
