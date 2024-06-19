import XCTest
@testable import ViaCep

final class MainPresenterTests: XCTestCase {
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let dataObject: DataCep = .dummy()
        let (sut, viewControllerSpy) = makeSut()
         
        sut.presentCep(dataObject)
         
        XCTAssertNotNil(dataObject)
        XCTAssertTrue(viewControllerSpy.didPresentCepCalled)
        XCTAssertEqual(viewControllerSpy.didPresentCepCalledCounting, 1)
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
        XCTAssertEqual(viewControllerSpy.didShowErrorCalledCouting, 1)
        XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
    }
}
