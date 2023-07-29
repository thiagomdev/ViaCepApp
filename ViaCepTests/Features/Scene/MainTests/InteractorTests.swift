import XCTest
@testable import ViaCep

final class InteractorTests: XCTestCase {
    typealias DataCepMock = DataCep
    
    func test_ShowCep_WhenTheServiceSearchAValidCep_ShouldReturnAValidCep() {
        // Given
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let data = DataCepMock.fixture(cep: "02349985")
        
        // When
        serviceSpy.expexted = .success(data)
        sut.showCep(data.cep)
        
        // Then
        XCTAssertEqual(presenterSpy.wasCalled, true)
        XCTAssertEqual(presenterSpy.howManyTimes, 1)
        XCTAssertEqual(presenterSpy.expected, "02349985")
    }
    
    func test_Failure() {
        // Given
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let data = DataCepMock.fixture(cep: "02349985")
        let error = NSError(domain: "", code: 0, userInfo: nil)

        // When
        serviceSpy.expexted = .failure(error)
        sut.showCep(data.cep)
        
        // Then
        XCTAssertEqual(presenterSpy.wasCalled, true)
        XCTAssertEqual(presenterSpy.howManyTimes, 1)
    }
    
    func test_ClearText_WhenNeedToClearText_ShouldReturnNilToClearAllOfThen() {
        // Given
        let (sut, presenterSpy, _) = makeSut()
        
        // When
        let expected = sut.clearText()

        // Then
        XCTAssertEqual(presenterSpy.expected, expected)
    }
    
    
    func test_DisplayInvalidCep() {
        // Given
        let (sut, presenterSpy, _) = makeSut()
        let data: DataCepMock = .fixture()
        // When
        sut.displayInvalidCep(data)

        // Then
        XCTAssertEqual(presenterSpy.wasCalled, true)
        XCTAssertEqual(presenterSpy.howManyTimes, 1)
        XCTAssertEqual(presenterSpy.dataModelExpected, data)
    }
    
    private func makeSut() -> (
        sut: MainInteractor,
        presenterSpy: PresenterSpy,
        serviceSpy: ServiceMock
    ) {
        
        let serviceSpy = ServiceMock()
        let presenterSpy = PresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
        return (sut, presenterSpy, serviceSpy)
    }
}

final class PresenterSpy: MainPresenting {
    
    private(set) var expected: String?
    private(set) var dataModelExpected: DataCep?
    private(set) var wasCalled: Bool =  false
    private(set) var howManyTimes: Int = 0
        
    func presentCep(_ cep: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        expected = cep.cep
    }
    
    func displayError(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        expected = message
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        dataModelExpected = data
    }
}

final class ServiceMock: MainServicing {
    var expexted: (Result<ViaCep.DataCep, Error>)?
    
    private(set) var wasCalled: Bool =  false
    private(set) var howManyTimes: Int = 0
    
    func getCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        guard let expexted = expexted else { return }
        wasCalled = true
        howManyTimes += 1
        callback(expexted)
    }
}
