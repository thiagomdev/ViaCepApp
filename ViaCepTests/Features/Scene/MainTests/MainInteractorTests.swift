import XCTest
@testable import ViaCep

final class MainInteractorTests: XCTestCase {
    func test_showCep_whenTheServiceSearchAValidCep_shouldReturnAValidCep() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
    }
 
    func test_failure() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        let error = NSError(domain: "", code: 0, userInfo: nil)
        doubles.serviceSpy.expexted = .failure(error)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertFalse(doubles.presenterSpy.presentCepCalled)
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
        
        XCTAssertTrue(doubles.presenterSpy.displayInvalidCepAlertMessageCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.displayInvalidCepAlertMessage(dataObject)])
    }
}

extension MainInteractorTests {
    private typealias Doubles = (
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
