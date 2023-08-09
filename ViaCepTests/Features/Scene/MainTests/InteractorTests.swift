import XCTest
@testable import ViaCep

final class InteractorTests: XCTestCase {
    private let dataObject: DataCep = .fixture()
    
    func test_ShowCep_WhenTheServiceSearchAValidCep_ShouldReturnAValidCep() {
        // Given - Arrange
        let (sut, presenterSpy, serviceSpy) = makeSut()
        serviceSpy.expexted = .success(.fixture())
        
        // When - Act
        sut.showCep(dataObject.cep)

        // Then - Assert
        XCTAssertEqual(serviceSpy.getCepWasCalled, true)
        XCTAssertEqual(serviceSpy.getCepCounter, 1)
        XCTAssertEqual(presenterSpy.messages, [.presentCep(dataObject)])
    }
 
    func test_Failure() {
        // Given - Arrange
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let error = NSError(domain: "", code: 0, userInfo: nil)

        // When - Act
        serviceSpy.expexted = .failure(error)
        sut.showCep(dataObject.cep)

        // Then - Assert
        XCTAssertEqual(serviceSpy.getCepWasCalled, true)
        XCTAssertEqual(serviceSpy.getCepCounter, 1)
        XCTAssertEqual(presenterSpy.messages, [.displayError(error.localizedDescription)])
    }
    
    func test_ClearText_WhenNeedToClearText_ShouldReturnNilToClearAllOfThen() {
        // Given - Arrange
        let (sut, presenterSpy, _) = makeSut()
        
        // When - Act
        let expected = sut.clearText()

        // Then - Assert
        XCTAssertEqual(presenterSpy.expected, expected)
    }
    
    func test_DisplayInvalidCep() {
        // Given - Arrange
        let (sut, presenterSpy, _) = makeSut()
        
        // When - Act
        sut.displayInvalidCep(dataObject)
        
        // Then - Assert
        XCTAssertEqual(presenterSpy.messages, [.displayInvalidCepAlertMessage(dataObject)])
    }
}

extension InteractorTests {
    private func makeSut() -> (
        sut: MainInteractor,
        presenterSpy: InteractorSpy,
        serviceSpy: ServiceMock
    ) {
        let serviceSpy = ServiceMock()
        let presenterSpy = InteractorSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
        return (sut, presenterSpy, serviceSpy)
    }
}
