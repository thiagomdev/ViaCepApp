import XCTest
@testable import ViaCep

final class PresenterTests: XCTestCase {
    private let dataObject: DataCep = .fixture()
    
    func test_PresentCep_WhenGetsAllOfInformationData_ShouldReturnDataCep() {
        let (sut, viewControllerSpy) = makeSut()
        
        sut.presentCep(.fixture())
        
        XCTAssertEqual(viewControllerSpy.messages, [.didShowCep(.fixture())])
    }
    
    func test_didShowError() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
    }
    
    func test_DidDisplayInvalidCepMessage() {
        let (sut, viewControllerSpy) = makeSut()
        
        sut.displayInvalidCepAlertMessage(dataObject)
        
        XCTAssertEqual(viewControllerSpy.messages, [.didDisplayInvalidCepMessage(dataObject.cep)])
    }
}

extension PresenterTests {
    private func makeSut() -> (
        sut: MainPresenter,
        viewControllerSpy: ViewControllerSpy
    ) {
        let coordinator = MainCoordinator()
        let viewControllerSpy = ViewControllerSpy()
        let sut = MainPresenter(coordinator: coordinator)
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
}
