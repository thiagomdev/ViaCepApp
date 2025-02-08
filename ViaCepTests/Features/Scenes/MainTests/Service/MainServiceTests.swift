import Testing
import Foundation
import ViaCep

@Suite("MainServiceTests", .serialized, .tags(.main))
private final class MainServiceTests {
    @Test("fetch_DataCep_whenTypeSomeCep_thenShouldReturnedValidDataCep")
    func test_fetchData_whenTypeSomeCep_thenShouldReturnedValidDataCep() {
        let (sut, networkingSpy) = makeSut()
        var dataObject: DataCep = .fixture()
        
        networkingSpy.expected = .success(dataObject)
        
        sut.fetchDataCep(dataObject.cep) { result in
            if case let .success(receivedObject) = result {
                dataObject = receivedObject
                #expect(dataObject == receivedObject)
                #expect(dataObject == .fixture())
                #expect(dataObject.cep == "01150011")
                #expect(networkingSpy.executeCalled == true)
                #expect(networkingSpy.executeCount == 1)
            }
        }
    }
    
    @Test("test_failure_on_non_200_HTTPResponse")
    func test_failure_on_non_200_HTTPResponse() {
        let (sut, networkingSpy) = makeSut()
        let failure: NSError = .init(domain: "expected error", code: -999)
        networkingSpy.expected = .failure(failure)
        
        var expectedFailure: Error?
       
        sut.fetchDataCep("01150011") { result in
            if case let .failure(receivedError) = result {
                expectedFailure = receivedError
                #expect(networkingSpy.executeCalled == true)
                #expect(networkingSpy.executeCount == 1)
                #expect(expectedFailure != nil)
            }
        }
    }
}

extension MainServiceTests {
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainServicing,
        networkingSpy: NetworkingSpy) {
            
        let networkingSpy = NetworkingSpy()
        let sut = MainService(networking: networkingSpy)

        return (sut, networkingSpy)
    }
}
