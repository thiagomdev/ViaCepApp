import Foundation

enum HttpMethod {
    case get
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
