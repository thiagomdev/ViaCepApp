import Foundation
@testable import ViaCep

enum NetworkingError: Error {
    case unknown
}

final class TaskDummy: Task {
    var request: ViaCep.Request = RequestDummy()
    
    func resume() {}
    
    func cancel() {}
}

final class RequestDummy: Request {
    var endpoint: String = ""
    
    var method: ViaCep.HttpMethod = .get
    
    var parameters: [String : String]?
    
    var headers: [String : String]?
    
    var body: Data?
}
