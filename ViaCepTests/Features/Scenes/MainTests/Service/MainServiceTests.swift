import Testing
import Foundation
import ViaCep

@Suite("MainServiceTests", .serialized, .tags(.main))
private final class MainServiceTests {
    // MARK: - Tests
    @Test("fetch_DataCep_whenTypeSomeCep_thenShouldReturnedValidDataCep")
    func test_fetchData_whenTypeSomeCep_thenShouldReturnedValidDataCep() {
        let (sut, networkingSpy) = makeSut()
        var dataObject: DataCep = .fixture()
        
        networkingSpy.expected = .success(.fixture(cep: "01150011"))
        
        sut.fetchDataCep("01150011") { result in
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
    
    // MARK: - Helpers
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainServicing,
        networkingSpy: NetworkingSpy) {
            
        let networkingSpy = NetworkingSpy()
        let sut = MainService(networking: networkingSpy)

        return (sut, networkingSpy)
    }
    
    private final class NetworkingSpy: NetworkingProtocol {
        var expected: (Result<DataCep, Error>) = .failure(NetworkingError.unknown)
        
        private(set) var executeCalled: Bool = false
        private(set) var executeCount: Int = 0
        
        func execute<T>(
            request: ViaCep.Request,
            responseType: T.Type,
            callback: @escaping (Result<T, Error>
            ) -> Void) -> ViaCep.Task where T : Decodable, T : Encodable {
            executeCalled = true
            executeCount += 1
            
            callback(expected as! Result<T, Error>)
            
            return TaskDummy()
        }
    }
}
