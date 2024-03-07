import XCTest
@testable import ViaCep

final class MainInteractorTests: XCTestCase {
    func test_showCep_whenTheServiceSearchAValidCep_shouldReturnAValidCep() {
        let dataObject: DataCep = .fixture()
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.serviceSpy)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
    
    func test_cep() {
        let dataObject: DataCep = .fixture(cep: "01150011")
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.serviceSpy)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
    
    func test_logradouro() {
        let dataObject: DataCep = .fixture(logradouro: "Alguma rua - teste")
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.logradouro)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.serviceSpy)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
    
    func test_localidade() {
        let dataObject: DataCep = .fixture(localidade: "Teste")
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.localidade)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.serviceSpy)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
    
    func test_bairro() {
        let dataObject: DataCep = .fixture(bairro: "Teste - Testing")
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.bairro)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.serviceSpy)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
 
    func test_failure() {
        let dataObject: DataCep = .fixture()
        let (sut, doubles) = makeSut()
        let error = NSError(domain: "", code: 0, userInfo: nil)
        doubles.serviceSpy.expexted = .failure(error)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertFalse(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.displayError(error.localizedDescription)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.serviceSpy)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
    
    func test_clearText_whenNeedToClearText_shouldReturnNilToClearAllOfThen() {
        let (sut, doubles) = makeSut()
        
        let expected = sut.clearText()

        XCTAssertEqual(doubles.presenterSpy.expected, expected)
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
    
    func test_displayInvalidCep() {
        let dataObject: DataCep = .fixture()
        let (sut, doubles) = makeSut()
        
        sut.displayInvalidCep(dataObject)
        
        XCTAssertTrue(doubles.presenterSpy.displayInvalidCepAlertMessageCalled)
        XCTAssertEqual(doubles.presenterSpy.messages, [.displayInvalidCepAlertMessage(dataObject)])
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: doubles.presenterSpy)
    }
}

extension MainInteractorTests {
    private typealias Doubles = (
        presenterSpy: MainPresenterSpy,
        serviceSpy: ServiceMock
    )

    private func makeSut() -> (
        sut: MainInteractor,
        doubles: Doubles
    ) {
        let serviceSpy = ServiceMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
        return (sut, (presenterSpy, serviceSpy))
    }
    
    private func trackForMemoryLeaks(to
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
