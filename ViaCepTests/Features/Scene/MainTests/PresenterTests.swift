import XCTest
@testable import ViaCep

final class PresenterTests: XCTestCase {
    typealias DataCepMock = DataCep
    
    func test_PresentCep_WhenGetsAllOfInformationData_ShouldReturnDataCep() {
        // Given
        let (sut, viewControllerSpy) = makeSut()
        
        // When
        sut.presentCep(.fixture())
        
        // Then
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.expected, .fixture())
    }
    
    func test_didShowError() {
        // Given
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        // When
        sut.displayError(message)
        
        // Then
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.errorMessage, message)
    }
    
    func test_DidDisplayInvalidCepMessage() {
        // Given
        let (sut, viewControllerSpy) = makeSut()
        
        // When
        let data: DataCepMock = .fixture(cep: "01150011")
        sut.displayInvalidCepAlertMessage(data)
        
        // Then
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.errorMessage, data.cep)
    }
    
    private func makeSut() -> (sut: MainPresenter, viewControllerSpy: ViewControllerSpy) {
        let coordinator = MainCoordinator()
        let viewControllerSpy = ViewControllerSpy()
        let sut = MainPresenter(coordinator: coordinator)
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
}

final class ViewControllerSpy: MainViewControlling {

    private(set) var wasCalled: Bool = false
    private(set) var errorMessage: String?
    private(set) var howManyTimes: Int = 0
    var expected: DataCep?
    
    func didShowCep(_ cep: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        expected = cep
    }
    
    func didShowError(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        errorMessage = message
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        errorMessage = message
    }
}
