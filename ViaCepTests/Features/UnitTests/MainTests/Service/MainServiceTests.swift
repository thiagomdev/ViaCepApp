import XCTest
@testable import ViaCep

final class MainServiceTests: XCTestCase {
    func test_success() {
        let (sut, doubles) = makeSut()
        let data: DataCep = .dummy()
        let exp = expectation(description: "Wait for a completion loading.")
        
        doubles.serviceSpy.shouldBeExpected = .success(.dummy())
        
        sut.fetchDataCep(data.cep) { result in
            if case .success(let dataObject) = result {
                XCTAssertNotNil(dataObject)
                XCTAssertFalse(dataObject.cep.isEmpty)
                XCTAssertFalse(dataObject.bairro.isEmpty)
                XCTAssertFalse(dataObject.localidade.isEmpty)
                XCTAssertFalse(dataObject.logradouro.isEmpty)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
    
    func test_failure() {
        let (sut, doubles) = makeSut()
        let exp = expectation(description: "Wait for a completion loading.")
        let failure: NSError = .init(domain: "error", code: 400)
        
        doubles.serviceSpy.shouldBeExpected = .failure(failure)
        
        sut.fetchDataCep("011500111") { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                exp.fulfill()
            } 
        }
        wait(for: [exp], timeout: 5.0)
    }
}
