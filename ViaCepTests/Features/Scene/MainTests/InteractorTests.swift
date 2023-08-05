import XCTest
@testable import ViaCep

final class InteractorTests: XCTestCase {
    typealias Mock = DataCep
    
    func test_ShowCep_WhenTheServiceSearchAValidCep_ShouldReturnAValidCep() {
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let data = Mock.dummy()
        
        serviceSpy.expexted = .success(data)
        sut.showCep(data.cep)

        XCTAssertEqual(presenterSpy.messages, [.presentCep(data)])
    }
    
    func test_Failure() {
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let data = Mock.dummy()
        let error = NSError(domain: "", code: 0, userInfo: nil)

        serviceSpy.expexted = .failure(error)
        sut.showCep(data.cep)

        XCTAssertEqual(presenterSpy.messages, [.displayError(error.localizedDescription)])
    }
    
    func test_ClearText_WhenNeedToClearText_ShouldReturnNilToClearAllOfThen() {
        let (sut, presenterSpy, _) = makeSut()
        
        let expected = sut.clearText()

        XCTAssertEqual(presenterSpy.expected, expected)
    }
    
    func test_DisplayInvalidCep() {
        let (sut, presenterSpy, _) = makeSut()
        let data: Mock = .dummy()
        
        sut.displayInvalidCep(data)
        
        XCTAssertEqual(presenterSpy.messages, [.displayInvalidCepAlertMessage(data)])
    }
}

extension InteractorTests {
    private func makeSut() -> (
        sut: MainInteractor,
        presenterSpy: InteractorSpy,
        serviceSpy: ServiceMock
    ) {
        let serviceSpy = ServiceMock()
        let presenterSpy = InteractorSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
        return (sut, presenterSpy, serviceSpy)
    }
}
