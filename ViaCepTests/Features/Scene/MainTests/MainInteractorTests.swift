import XCTest
@testable import ViaCep

final class MainInteractorTests: XCTestCase {
    func test_showCep_whenTheServiceSearchAValidCep_shouldReturnAValidCep() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        
        sut.displayCep(dataObject.cep)
        doubles.serviceSpy.expexted.first?(.success(dataObject))
        
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
    }
 
    func test_failure() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        let error = NSError(domain: "", code: 0, userInfo: nil)

        sut.displayCep(dataObject.cep)
        doubles.serviceSpy.expexted.first?(.failure(error))
        
        XCTAssertEqual(doubles.presenterSpy.messages, [.displayError(error.localizedDescription)])
    }
    
    func test_clearText_whenNeedToClearText_shouldReturnNilToClearAllOfThen() {
        let (sut, doubles) = makeSut()
        
        let expected = sut.clearText()

        XCTAssertEqual(doubles.presenterSpy.expected, expected)
    }
    
    func test_displayInvalidCep() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        
        sut.displayInvalidCep(dataObject)
        
        XCTAssertEqual(doubles.presenterSpy.messages, [.displayInvalidCepAlertMessage(dataObject)])
    }
}

extension MainInteractorTests {
    typealias Doubles = (
        presenterSpy: MainPresenterSpy,
        serviceSpy: ServiceMock
    )

    private func makeSut() -> (
        sut: MainInteractor,
        doubles: Doubles
    ) {
        let serviceSpy = ServiceMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
        return (sut, (presenterSpy, serviceSpy))
    }
}
