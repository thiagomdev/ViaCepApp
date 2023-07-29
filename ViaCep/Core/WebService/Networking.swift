import Foundation

protocol NetworkingProtocol {
    func execute<T: Codable>(request: Request, responseType: T.Type, callback: @escaping (Result<T, Error>) -> Void) -> Task
}

final class Networking: NetworkingProtocol {
    func execute<T>(request: Request, responseType: T.Type, callback: @escaping (Result<T, Error>) -> Void) -> Task where T : Decodable, T : Encodable {
        Tasking<T>(request: request, callback: callback, responseType: responseType)
    }
}
