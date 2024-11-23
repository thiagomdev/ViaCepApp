import Foundation
import ViaCep
import Testing

@Suite("MainInteractorTests", .serialized, .tags(.main))
private final class MainInteractorTests {
    // MARK: - Tests
    @Test("displayCep_success")
    func display_cep_success() {
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expectedResponse = .success(.dummy())
        
        sut.displayCep("01150011")
        
        #expect(doubles.presenterSpy.presentCepCalled == true)
        #expect(doubles.presenterSpy.presentCepCouting == 1)
        
        #expect(doubles.presenterSpy.messages == [
            .presentCep(cep: .dummy(cep: "01150011"))
        ], "Should be returned all the correct object model")
        
        #expect(doubles.presenterSpy.displayErrorCalled == false)
        #expect(doubles.presenterSpy.displayErrorCalledCouting == 0)
    }
    
    @Test("displayCep_failure")
    func test_display_cep_failure() {
        let (sut, doubles) = makeSut()
        let samples = [199, 201, 300, 400, 500].enumerated()
        let err = NSError(
            domain: "Wainting for a conclusion of the request",
            code: samples.underestimatedCount
        )
        
        doubles.serviceSpy.expectedResponse = .failure(err)
        
        sut.displayCep("01150011")
      
        samples.forEach { _, _ in
            #expect(doubles.presenterSpy.presentCepCalled == false)
            #expect(doubles.presenterSpy.presentCepCouting == 0)
            
            #expect(doubles.presenterSpy.displayErrorCalled == true)
            #expect(doubles.presenterSpy.displayErrorCalledCouting == 1)
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
