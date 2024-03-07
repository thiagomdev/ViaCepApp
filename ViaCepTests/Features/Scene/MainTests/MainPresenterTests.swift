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
        trackForMemoryLeaks(for: sut)
        trackForMemoryLeaks(for: viewControllerSpy)
    }
    
    func test_didShowError() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        XCTAssertTrue(viewControllerSpy.didShowErrorCalled)
        XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
        trackForMemoryLeaks(for: sut)
        trackForMemoryLeaks(for: viewControllerSpy)
    }
    
    func test_didDisplayInvalidCepMessage() {
        let dataObject: DataCep = .fixture()
        let (sut, viewControllerSpy) = makeSut()
        
        sut.displayInvalidCepAlertMessage(dataObject)
        
        XCTAssertTrue(viewControllerSpy.didDisplayInvalidCepMessageCalled)
        XCTAssertEqual(
            viewControllerSpy.messages, [
                .didDisplayInvalidCepMessage(dataObject.cep)
            ]
        )
        trackForMemoryLeaks(for: sut)
        trackForMemoryLeaks(for: viewControllerSpy)
    }
}

extension MainPresenterTests {
    private func makeSut() -> (
        sut: MainPresenter,
        viewControllerSpy: MainViewControllerSpy
    ) {
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
    
    private func trackForMemoryLeaks(for
        instance: AnyObject,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak."
            )
        }
    }
}
