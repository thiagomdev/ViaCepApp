import Foundation
@testable import ViaCep

enum NetworkingError: Error {
    case unknown
}

final class NetworkingSpy: NetworkingProtocol {
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
