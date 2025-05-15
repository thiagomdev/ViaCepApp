import Testing
import Foundation
import ViaCep

@Suite(.serialized, .tags(.mainPresenter))
final class MainPresenterTests {
    
    private var sutTracker: MemoryLeakDetection<MainPresenter>?
    private var viewControllerSpyTracker: MemoryLeakDetection<MainViewControllerSpy>?
    
    @Test
    func present_cep() {
        let (sut, viewControllerSpy) = makeSut()
        
        sut.presentCep(.fixture())
        
        #expect(viewControllerSpy.didPresentCepCalled == true)
        #expect(viewControllerSpy.didPresentCepCalledCounting == 1)
        #expect(viewControllerSpy.failure.isEmpty == false)
        #expect(viewControllerSpy.responseDataCep.isEmpty == false)
        #expect(viewControllerSpy.responseDataCep == [.fixture()])
    }
    
    @Test
    func display_error() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        #expect(viewControllerSpy.didPresentCepCalled == false)
        #expect(viewControllerSpy.didPresentCepCalledCounting == 0)
        #expect(viewControllerSpy.didShowErrorCalled == true)
        #expect(viewControllerSpy.didShowErrorCalledCouting == 1)
        #expect(viewControllerSpy.messages == [.didShowError(message)])
    }
    
    deinit {
        sutTracker?.verify()
        viewControllerSpyTracker?.verify()
    }
}

extension MainPresenterTests {
    private func makeSut(file: String = #file, line: Int = #line, column: Int = #column) -> (sut: MainPresenter, viewControllerSpy: MainViewControllerSpy) {
                
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.mainView = viewControllerSpy
        
        let sourceLocation = SourceLocation(fileID: #fileID, filePath: file, line: line, column: column)
        
        sutTracker = .init(object: sut, sourceLocation: sourceLocation)
        viewControllerSpyTracker = .init(object: viewControllerSpy, sourceLocation: sourceLocation)
        
        return (sut, viewControllerSpy)
    }
}
