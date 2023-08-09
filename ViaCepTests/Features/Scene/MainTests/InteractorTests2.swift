import XCTest
@testable import ViaCep

final class InteractorTests2: XCTestCase {
    private let presenterSpy = PresenterSpy2()
    private var serviceSpy = ServiceSpy2()
    
    private lazy var sut: MainInteractor = {
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy)
        return sut
    }()
    
    func test_ShowCep_WhenCallingShowCep_ShouldCallPresenterWithCorrectData() {
        // Given - Arrange
        let stub = Stub.dataObject()
        serviceSpy.dataObjectExpected = .success(stub)
        
        // When - Act
        sut.showCep(stub.cep)
        
        // Then - Assert
        XCTAssertTrue(presenterSpy.presentCepIsCalled)
        XCTAssertEqual(presenterSpy.presentCepCounter, 1)
        XCTAssertEqual(presenterSpy.expectedData, stub)
    }
    
    func test_ShowCep_WhenCallingShowCep_ShouldCallPresenterWithValidDataAfterError() {
        // Given - Arrange
        let stub = Stub.dataObject()
        let error = NSError(domain: "", code: 0, userInfo: nil)
        serviceSpy.dataObjectExpected = .failure(error)
        
        // When - Act
        sut.showCep(stub.cep)
        
        // Then - Assert
        XCTAssertTrue(serviceSpy.getCepCalled)
        XCTAssertEqual(serviceSpy.getCepCounting, 1)
        XCTAssertEqual(presenterSpy.errorMessageExpexted, error.localizedDescription)
    }
    
    func test_DisplayInvalidCep_WhenCallingDisplayInvalidCep_ShouldCallPresenterWithErrorAndCorrectData() {
        // Given - Arrange
        let stub = Stub.dataObject()
        // When - Act
        sut.displayInvalidCep(stub)
        
        // Then - Assert
        XCTAssertEqual(presenterSpy.expectedData, stub)
    }
    
    func test_clearText() {
        // Given - Arrange
        let expectedResult = sut.clearText()
        
        // Then - Assert
        XCTAssertEqual(presenterSpy.errorMessageExpexted, expectedResult)
    }
}

final class PresenterSpy2: MainPresenting {
    private(set) var presentCepIsCalled: Bool = false
    private(set) var displayErrorIsCalled: Bool = false
    
    private(set) var presentCepCounter: Int = 0
    private(set) var displayErrorCounter: Int = 0
    
    private(set) var expectedData: DataCep?
    private(set) var errorMessageExpexted: String?
    
    func presentCep(_ cep: ViaCep.DataCep) {
        presentCepIsCalled = true
        presentCepCounter += 1
        expectedData = cep
    }
    
    func displayError(_ message: String) {
        displayErrorIsCalled = true
        displayErrorCounter += 1
        errorMessageExpexted = message
    }
    
    func displayInvalidCepAlertMessage(_ data: ViaCep.DataCep) {
        expectedData = data
    }
}

final class ServiceSpy2: MainServicing {
    var dataObjectExpected: (Result<ViaCep.DataCep, Error>)?
    private(set) var getCepCalled: Bool = false
    private(set) var getCepCounting: Int = 0
    
    func getCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        guard let dataObject = dataObjectExpected else { return }
        getCepCalled = true
        getCepCounting += 1
        callback(dataObject)
    }
}

enum Stub {
    static func dataObject(
        cep: String = "01150011",
        logradouro: String = "Marechal Deodoro",
        bairro: String = "Santa Cecília",
        localidade: String = "São Paulo"
    ) -> DataCep {
        let data = DataCep(
            cep: cep,
            logradouro: logradouro,
            bairro: bairro,
            localidade: localidade
        )
        return data
    }
}
