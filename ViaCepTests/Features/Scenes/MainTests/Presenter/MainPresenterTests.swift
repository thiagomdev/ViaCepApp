import XCTest
import Testing
import ViaCep

@Suite("MainPresenterTests", .serialized, .tags(.main))
final class MainPresenterTests {
    // MARK: - Tests
    @Test("presentCep")
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let (sut, viewControllerSpy) = makeSut()
        
        sut.presentCep(.dummy())
        
        #expect(viewControllerSpy.failure.isEmpty == false)
        #expect(viewControllerSpy.responseDataCep.isEmpty == false)
        #expect(viewControllerSpy.responseDataCep == [.dummy()])
    }
    
    @Test("displayError")
    func test_did_show_error() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        #expect(viewControllerSpy.didShowErrorCalled == true)
        #expect(viewControllerSpy.didShowErrorCalledCouting == 1)
        #expect(viewControllerSpy.messages == [.didShowError(message)])
    }
    
    // MARK: - Helpers
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
            sut: MainPresenting,
            viewControllerSpy: MainViewControllerSpy
        ) {
                
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.mainView = viewControllerSpy
        
        return (sut, viewControllerSpy)
    }
    
    private final class MainViewControllerSpy: MainViewProtocol {
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
}
