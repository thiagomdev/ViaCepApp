import Foundation
@testable import ViaCep

final class NetworkingSpy: NetworkingProtocol {
    func execute<T>(
        request: ViaCep.Request,
        responseType: T.Type,
        callback: @escaping (Result<T, Error>
        ) -> Void) -> ViaCep.Task where T : Decodable, T : Encodable {
        
        Tasking<T>(
            request: request,
            callback: callback,
            responseType: responseType
        )
    }
}
