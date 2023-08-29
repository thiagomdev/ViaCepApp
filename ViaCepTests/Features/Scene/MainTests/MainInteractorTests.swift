import XCTest
@testable import ViaCep

final class MainInteractorTests: XCTestCase {
    func test_ShowCep_WhenTheServiceSearchAValidCep_ShouldReturnAValidCep() {
        // Given - Arrange
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        // When - Act
        sut.displayCep(dataObject.cep)

        // Then - Assert
        XCTAssertEqual(doubles.serviceSpy.getCepWasCalled, true)
        XCTAssertEqual(doubles.serviceSpy.getCepCounter, 1)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
    }
 
    func test_Failure() {
        // Given - Arrange
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        let error = NSError(domain: "", code: 0, userInfo: nil)

        // When - Act
        doubles.serviceSpy.expexted = .failure(error)
        sut.displayCep(dataObject.cep)

        // Then - Assert
        XCTAssertEqual(doubles.serviceSpy.getCepWasCalled, true)
        XCTAssertEqual(doubles.serviceSpy.getCepCounter, 1)
        XCTAssertEqual(doubles.presenterSpy.messages, [.displayError(error.localizedDescription)])
    }
    
    func test_ClearText_WhenNeedToClearText_ShouldReturnNilToClearAllOfThen() {
        // Given - Arrange
        let (sut, doubles) = makeSut()
        
        // When - Act
        let expected = sut.clearText()

        // Then - Assert
        XCTAssertEqual(doubles.presenterSpy.expected, expected)
    }
    
    func test_DisplayInvalidCep() {
        // Given - Arrange
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        
        // When - Act
        sut.displayInvalidCep(dataObject)
        
        // Then - Assert
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
