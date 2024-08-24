import XCTest
import ViaCep

final class MainPresenterTests: XCTestCase {
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let (sut, viewControllerSpy) = makeSut()
         
        sut.presentCep(.dummy())
        
        XCTAssertFalse(viewControllerSpy.failure.isEmpty)
        XCTAssertFalse(viewControllerSpy.responseDataCep.isEmpty)
        XCTAssertEqual(viewControllerSpy.responseDataCep, [.dummy()])
    }
    
    func test_did_show_error() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        XCTAssertTrue(viewControllerSpy.didShowErrorCalled)
        XCTAssertEqual(viewControllerSpy.didShowErrorCalledCouting, 1)
        XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
    }
}

extension MainPresenterTests {
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainPresenting,
        viewControllerSpy: MainViewControllerSpy) {
            
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: viewControllerSpy, file: file, line: line)
        
        return (sut, viewControllerSpy)
    }
    
    private final class MainViewControllerSpy: MainViewControlling {
        enum Message: Hashable {
            case didShowCep(_ cep: ViaCep.DataCep)
            case didShowError(_ message: String)
        }
        
        private var message = [(cep: DataCep, error: Error)]()
        
        var responseDataCep: [DataCep] { message.map { $0.cep } }
        var failure: [Error] { message.map { $0.error } }
        
        private(set) var messages = Set<Message>()
        
        private(set) var didPresentCepCalled: Bool = false
        private(set) var didPresentCepCalledCounting: Int = 0
        
        private(set) var didShowErrorCalled: Bool = false
        private(set) var didShowErrorCalledCouting: Int = 0
        
        private(set) var didDisplayInvalidCepMessageCalled: Bool = false
        
        func didPresentCep(_ cep: ViaCep.DataCep) {
            message.append((cep, NSError()))
//            messages.insert(.didShowCep(cep))
        }
        
        func didShowErrorMessage(_ message: String) {
            didShowErrorCalled = true
            didShowErrorCalledCouting += 1
            messages.insert(.didShowError(message))
        }
    }
}
