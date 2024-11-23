import Foundation
import ViaCep
import Testing

@Suite("MainInteractorTests", .serialized, .tags(.mainInteractor))
final class MainInteractorTests {
    // MARK: - Tests
    @Test("displayCep_success")
    func display_cep_success() {
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expectedResponse = .success(.dummy())
        
        sut.displayCep("01150011")
        
        #expect(doubles.presenterSpy.message == [.dummy()])
    }
    
    @Test("displayCep_failure")
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
    
    @Test("clear_text")
    func test_clearText() {
        let (sut, _) = makeSut()
        
        let clearString = sut.clearText()
        
        #expect(clearString == nil)
    }
    
    // MARK: - Helpers
    private final class ServiceMock: MainServicing {
        var expectedResponse: (Result<ViaCep.DataCep, Error>)?
                
        func fetchDataCep(
            _ cep: String,
            callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
            if let result = expectedResponse {
                callback(result)
            }
        }
    }
    
    private typealias Doubles = (
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
}
