import XCTest
import ViaCep

final class MainPresenterTests: XCTestCase {
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let (sut, viewControllerSpy) = makeSut()
                
        expectSuccess(sut, toCompleteWith: .dummy(cep: "01150012")) {
            XCTAssertFalse(viewControllerSpy.failure.isEmpty)
            XCTAssertFalse(viewControllerSpy.responseDataCep.isEmpty)
            XCTAssertEqual(viewControllerSpy.responseDataCep, [.dummy(cep: "01150012")])
        }
    }
    
    func test_did_show_error() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        expectFailure(sut, onCompleteWith: message) {
            XCTAssertTrue(viewControllerSpy.didShowErrorCalled)
            XCTAssertEqual(viewControllerSpy.didShowErrorCalledCouting, 1)
            XCTAssertEqual(viewControllerSpy.messages, [.didShowError(message)])
        }
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
        
        var messages = Set<Message>()
        
        private(set) var didPresentCepCalled: Bool = false
        private(set) var didPresentCepCalledCounting: Int = 0
        
        private(set) var didShowErrorCalled: Bool = false
        private(set) var didShowErrorCalledCouting: Int = 0
        
        private(set) var didDisplayInvalidCepMessageCalled: Bool = false
        
        func didPresentCep(_ cep: ViaCep.DataCep) {
            message.append((cep, NSError()))
        }
        
        func didShowErrorMessage(_ message: String) {
            didShowErrorCalled = true
            didShowErrorCalledCouting += 1
            messages.insert(.didShowError(message))
        }
    }
    
    private func expectSuccess(
        _ sut: MainPresenting,
        toCompleteWith dataCep: DataCep,
        when action: () -> Void,
        file: StaticString = #file,
        line: UInt = #line) {
            
        sut.presentCep(dataCep)
        
        action()
        
        XCTAssertNotNil(dataCep, file: file, line: line)
    }
    
    private func expectFailure(
        _ sut: MainPresenting,
        onCompleteWith message: String,
        when action: () -> Void,
        file: StaticString = #file,
        line: UInt = #line) {
            
        sut.displayError(message)
            
        action()
        
        XCTAssertNotNil(message, file: file, line: line)
    }
}
