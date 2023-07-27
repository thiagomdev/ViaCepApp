import Foundation

enum MainAPIRequest: Request {
    case cep(String)
    
    var endpoint: String {
        switch self {
        case let .cep(cep):
            return "/\(cep)/json/"
        }
    }
    
    var method: HttpMethod { .get }
    
    var headers: [String : String]? { nil }
    var body: Data? { nil }
    var parameters: [String : String]? { nil }
}

