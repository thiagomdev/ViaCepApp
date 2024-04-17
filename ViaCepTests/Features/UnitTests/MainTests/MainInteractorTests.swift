import XCTest
@testable import ViaCep

final class MainInteractorTests: XCTestCase {
    func test_showCep_whenTheServiceSearchAValidCep_shouldReturnAValidCep() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        doubles.serviceSpy.expexted = .success(dataObject)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertNotNil(dataObject)
        XCTAssertTrue(doubles.serviceSpy.fetchDataCepCalled)
        XCTAssertEqual(doubles.serviceSpy.fetchDataCepCalledCounting, 1)
        
        XCTAssertTrue(doubles.presenterSpy.presentCepCalled)
        XCTAssertEqual(doubles.presenterSpy.presentCepCallCounting, 1)
        XCTAssertEqual(doubles.presenterSpy.messages, [.presentCep(dataObject)])
        
        XCTAssertEqual(dataObject.cep, "01150011")
        XCTAssertEqual(dataObject.logradouro, "Praça Marechal Deodoro")
        XCTAssertEqual(dataObject.localidade, "São Paulo")
        XCTAssertEqual(dataObject.bairro, "Santa Cecília")
    }
    
    func test_failure() {
        let dataObject: DataCep = .dummy()
        let (sut, doubles) = makeSut()
        let err = NSError(domain: "", code: 400, userInfo: nil)
        doubles.serviceSpy.expexted = .failure(err)
        
        sut.displayCep(dataObject.cep)
        
        XCTAssertTrue(doubles.serviceSpy.fetchDataCepCalled)
        XCTAssertEqual(doubles.serviceSpy.fetchDataCepCalledCounting, 1)
        XCTAssertNotNil(dataObject)
        
        XCTAssertTrue(doubles.presenterSpy.displayErrorCalled)
        XCTAssertEqual(doubles.presenterSpy.displayErrorCalledCouting, 1)
        XCTAssertEqual(doubles.presenterSpy.messages, [
            .displayError(err.localizedDescription)]
        )
    }
    
    func test_clearText_whenNeedToClearText_shouldReturnNilToClearAllOfThen() {
        let spy = MainPresenterSpy()
        let serviceSpy = ServiceMock()
        let sut = makeSut(presenterSpy: spy, serviceSpy: serviceSpy)
        
        let expected = sut.clearText()

        XCTAssertEqual(spy.expected, expected)
    }
}

extension MainInteractorTests {
    private typealias Doubles = (
        presenterSpy: MainPresenterSpy,
        serviceSpy: ServiceMock
    )

    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainInteractor,
        doubles: Doubles
    ) {
        
        let serviceSpy = ServiceMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy)
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: presenterSpy, file: file, line: line)
        trackForMemoryLeaks(to: serviceSpy, file: file, line: line)
        
        return (sut, (presenterSpy, serviceSpy))
    }
    
    private func makeSut(
        presenterSpy: MainPresenting = MainPresenterSpy(),
        serviceSpy: MainServicing = ServiceMock(),
        
        file: StaticString = #file,
        line: UInt = #line) -> MainInteractor {

        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy)
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
            
        return sut
    }
}
