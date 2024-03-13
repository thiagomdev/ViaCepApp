import XCTest
@testable import ViaCep

final class MainServiceTests: XCTestCase {
    func test_fetchDataCep() {
        switch fetchDataCep {
        case let .success(dataObject):
            XCTAssertNotNil(dataObject)
            
            XCTAssertFalse(dataObject.cep.isEmpty)
            XCTAssertFalse(dataObject.bairro.isEmpty)
            XCTAssertFalse(dataObject.localidade.isEmpty)
            XCTAssertFalse(dataObject.logradouro.isEmpty)
            
            XCTAssertEqual(dataObject.cep, "01226-010")
            XCTAssertEqual(dataObject.bairro, "Vila Buarque")
            XCTAssertEqual(dataObject.localidade, "São Paulo")
            XCTAssertEqual(dataObject.logradouro, "Rua das Palmeiras")
            
        case let .failure(error):
            XCTFail(
                "Expected successful data result but, got an \(error) instead."
            )
        default:
            XCTFail("Expected successful but, got no result instead.")
        }
    }
}

extension MainServiceTests {
    private func makeSut() -> (
        sut: MainService,
        serviceSpy: MainServiceSpy,
        networkingSpy: NetworkingSpy
    ) {
        let networkingSpy = NetworkingSpy()
        let serviceSpy = MainServiceSpy()
        let sut = MainService(networking: networkingSpy)
        return (sut, serviceSpy, networkingSpy)
    }
    
    private var fetchDataCep: Result<DataCep, Error>? {
        let (sut, serviceSpy, _) = makeSut()
        trackForMemoryLeaks(to: sut)
        
        let exp = expectation(
            description: "Wait for a completion loading."
        )
        
        let data: DataCep = .fixture(cep: "01226-010")
        var expected = serviceSpy.shouldBeExpected
        
        sut.fetchDataCep(data.cep) { result in
            expected = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10.0)
        return expected
    }
}
