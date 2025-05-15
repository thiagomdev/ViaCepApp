import Testing
import Foundation
import ViaCep

@Suite(.serialized, .tags(.main))
final class MainServiceTests {
    
    private var sutTracker: MemoryLeakDetection<MainService>?
    private var networkingSpyTracker: MemoryLeakDetection<NetworkingSpy>?
    
    @Test(arguments: [DataCep.fixture()])
    func fetch_data_cep_success(fixture: DataCep) async throws {
        let (sut, networkingSpy) = makeSut()
        networkingSpy.expected = .success(fixture)
        
        do {
            let result = try await withCheckedThrowingContinuation { continuation in
                sut.fetchDataCep("0000-000") { result in
                    switch result {
                    case let .success(cep):
                        continuation.resume(returning: cep)
                        case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            #expect(result != nil)
            #expect(result == .fixture())
            #expect(networkingSpy.executeCalled == true)
            #expect(networkingSpy.executeCount == 1)
           
        } catch {
            Issue.record("Expected to succeed, but failed due to error: \(error)")
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
