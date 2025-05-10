import Testing
import Foundation
import ViaCep

@Suite("MainServiceTests", .serialized, .tags(.main))
final class MainServiceTests {
    
    private var sutTracker: MemoryLeakTracker<MainService>?
    private var networkingSpyTracker: MemoryLeakTracker<NetworkingSpy>?
    
    @Test
    func fetch_data_cep_success() {
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
    
    @Test
    func fetch_data_cep_failure() {
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
    
    deinit {
        sutTracker?.verify()
        networkingSpyTracker?.verify()
    }
}

extension MainServiceTests {
    private func makeSut(file: String = #file, line: Int = #line, column: Int = #column) -> (sut: MainService, networkingSpy: NetworkingSpy) {
            
        let networkingSpy = NetworkingSpy()
        let sut = MainService(networking: networkingSpy)

        let sourceLocation = SourceLocation(fileID: #fileID, filePath: file, line: line, column: column)
        sutTracker = .init(object: sut, sourceLocation: sourceLocation)
        networkingSpyTracker = .init(object: networkingSpy, sourceLocation: sourceLocation)
        
        return (sut, networkingSpy)
    }
}
