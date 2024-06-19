import XCTest
@testable import ViaCep

final class MainInteractorTests: XCTestCase {
    func test_display_cep_success() {
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
    
    func test_display_cep_failure() {
        let (sut, doubles) = makeSut()
        let err = NSError(domain: "", code: 400, userInfo: nil)
        doubles.serviceSpy.expexted = .failure(err)
        
        sut.displayCep("011500111")
        
        XCTAssertTrue(doubles.serviceSpy.fetchDataCepCalled)
        XCTAssertEqual(doubles.serviceSpy.fetchDataCepCalledCounting, 1)
        
        XCTAssertTrue(doubles.presenterSpy.displayErrorCalled)
        XCTAssertEqual(doubles.presenterSpy.displayErrorCalledCouting, 1)
        XCTAssertEqual(doubles.presenterSpy.messages, [
            .displayError(err.localizedDescription)]
        )
    }
    
    func test_clear_text() {
        let (sut, doubles) = makeSut()
        
        let expected = sut.clearText()

        XCTAssertEqual(doubles.presenterSpy.expected, expected)
    }
}
