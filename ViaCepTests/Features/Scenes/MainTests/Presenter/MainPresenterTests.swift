import Testing
import Foundation
import ViaCep

@Suite("MainPresenterTests", .serialized, .tags(.main))
private final class MainPresenterTests {
    // MARK: - Tests
    @Test("test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep")
    func test_presentCep_whenGetsAllOfInformationData_shouldReturnDataCep() {
        let (sut, viewControllerSpy) = makeSut()
        
        sut.presentCep(.dummy())
        
        #expect(viewControllerSpy.didPresentCepCalled == true, "Should be didPresentCepCalled true")
        #expect(viewControllerSpy.didPresentCepCalledCounting == 1, "Should be didPresentCepCalledCounting 1")
        #expect(viewControllerSpy.failure.isEmpty == false, "Should be failure false")
        #expect(viewControllerSpy.responseDataCep.isEmpty == false, "Should be responseDataCep false")
        #expect(viewControllerSpy.responseDataCep == [.dummy()], "The data object should be equal")
    }
    
    @Test("test_displayError_whenCalled_shouldDisplayError")
    func test_displayError_whenCalled_shouldDisplayError() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        #expect(viewControllerSpy.didPresentCepCalled == false, "Shouldn't be didPresentCepCalled true")
        #expect(viewControllerSpy.didPresentCepCalledCounting == 0, "Shouldn't be didPresentCepCalledCounting 1")
        #expect(viewControllerSpy.didShowErrorCalled == true, "Should be didShowErrorCalled true")
        #expect(viewControllerSpy.didShowErrorCalledCouting == 1, "Should be didShowErrorCalledCouting 1")
        #expect(viewControllerSpy.messages == [.didShowError(message)], "The message should be equal")
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
        
        private(set) var messages = Set<Message>()
        
        private(set) var didPresentCepCalled: Bool = false
        private(set) var didPresentCepCalledCounting: Int = 0
        
        private(set) var didShowErrorCalled: Bool = false
        private(set) var didShowErrorCalledCouting: Int = 0
        
        private(set) var didDisplayInvalidCepMessageCalled: Bool = false
        
        func didPresentCep(_ cep: ViaCep.DataCep) {
            didPresentCepCalled = true
            didPresentCepCalledCounting += 1
            message.append((cep, NSError()))
        }
        
        func didShowErrorMessage(_ message: String) {
            didShowErrorCalled = true
            didShowErrorCalledCouting += 1
            messages.insert(.didShowError(message))
        }
    }
}
