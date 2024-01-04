import XCTest
@testable import ViaCep

final class MainPresenterTests: XCTestCase {
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let dataObject: DataCep = .dummy()
        let (sut, viewControllerSpy) = makeSut()
        
        sut.presentCep(dataObject)
        
        XCTAssertEqual(viewControllerSpy.messages, [.didShowCep(dataObject)])
    }
    
    func test_didShowError() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
    }
    
    func test_didDisplayInvalidCepMessage() {
        let dataObject: DataCep = .dummy()
        let (sut, viewControllerSpy) = makeSut()
        
        sut.displayInvalidCepAlertMessage(dataObject)
        
        XCTAssertEqual(viewControllerSpy.messages, [.didDisplayInvalidCepMessage(dataObject.cep)])
    }
}

extension MainPresenterTests {
    private func makeSut() -> (
        sut: MainPresenter,
        viewControllerSpy: MainViewControllerSpy
    ) {
        let coordinator = MainCoordinator()
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter(coordinator: coordinator)
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
}
