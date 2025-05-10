import ViaCep
import Testing
import XCTest
import Foundation

@Suite("MainInteractorTests", .serialized, .tags(.main))
final class MainInteractorTests {
    
    private var sutTracker: MemoryLeakTracker<MainInteractor>?
    private var presenterSpyTracker: MemoryLeakTracker<MainPresenterSpy>?
    private var serviceSpyTracker: MemoryLeakTracker<ServiceMock>?
    
    @Test
    func display_cep_success() {
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expectedResponse = .success(.fixture())
        
        sut.displayCep("01150011")
        
        #expect(doubles.presenterSpy.presentCepCalled == true, "Should be called")
        #expect(doubles.presenterSpy.presentCepCouting == 1, "Should be called once")
        #expect(doubles.presenterSpy.messages == [.presentCep(cep: .fixture(cep: "01150011"))])
        #expect(doubles.presenterSpy.displayErrorCalled == false)
        #expect(doubles.presenterSpy.displayErrorCalledCouting == 0)
    }
    
    @Test
    func display_cep_failure() {
        let (sut, doubles) = makeSut()
        let samples = [199, 201, 300, 400, 500].enumerated()
        let err = NSError(
            domain: "Wainting for a conclusion of the request",
            code: samples.underestimatedCount
        )
        
        doubles.serviceSpy.expectedResponse = .failure(err)
        
        sut.displayCep("01150011")
      
        samples.forEach { _, _ in
            #expect(doubles.presenterSpy.presentCepCalled == false)
            #expect(doubles.presenterSpy.presentCepCouting == 0)
            
            #expect(doubles.presenterSpy.displayErrorCalled == true)
            #expect(doubles.presenterSpy.displayErrorCalledCouting == 1)
        }
    }
    
    @Test
    func clear_text() {
        let (sut, _) = makeSut()
        
        let clearString = sut.clearText()
        
        #expect(clearString == nil, "Should be nil")
    }
    
    deinit {
        sutTracker?.verify()
        presenterSpyTracker?.verify()
        serviceSpyTracker?.verify()
    }
}

extension MainInteractorTests {
    private typealias Doubles = (
        presenterSpy: MainPresenterSpy,
        serviceSpy: ServiceMock
    )
    
    private func makeSut(
        file: String = #file,
        line: Int = #line,
        column: Int = #column) -> (
            
        sut: MainInteractor,
        doubles: Doubles) {
        
        let serviceSpy = ServiceMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
            
        let sourceLocation = SourceLocation(fileID: #fileID, filePath: file, line: line, column: column)
            
        sutTracker = .init(object: sut, sourceLocation: sourceLocation)
        presenterSpyTracker = .init(object: presenterSpy, sourceLocation: sourceLocation)
        serviceSpyTracker = .init(object: serviceSpy, sourceLocation: sourceLocation)
            
        return (sut, (presenterSpy, serviceSpy))
    }
}
