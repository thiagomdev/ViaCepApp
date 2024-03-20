import XCTest
@testable import ViaCep

final class MainPresenterTests: XCTestCase {
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let dataObject: DataCep = .fixture()
        let (sut, viewControllerSpy) = makeSut()
         
        sut.presentCep(dataObject)
         
        XCTAssertTrue(viewControllerSpy.didPresentCepCalled)
        XCTAssertEqual(
            viewControllerSpy.messages, [
                .didShowCep(dataObject)
            ]
        )
    }
    
    func test_didShowError() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        XCTAssertTrue(viewControllerSpy.didShowErrorCalled)
        XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
    }
}

extension MainPresenterTests {
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (
        sut: MainPresenter,
        viewControllerSpy: MainViewControllerSpy
    ) {
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: viewControllerSpy)
        return (sut, viewControllerSpy)
    }
}
