import Foundation

public protocol Request {
    var baseUrl: String { get }
    var endpoint: String { get }
    var method: HttpMethod { get }
    
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

public protocol Task {
    var request: Request { get }
    func resume()
    func cancel()
}

extension Request {
    public var baseUrl: String {"https://viacep.com.br/ws" }
    
    public var url: String {
        var components = URLComponents()
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            parameters.forEach { key, value in
                queryItems.append(
                    URLQueryItem(
                        name: key,
                        value: value.addingPercentEncoding(
                            withAllowedCharacters: .urlPathAllowed)
                    )
                )
            }
            components.queryItems = queryItems
            return baseUrl + endpoint + components.path
        }
        return baseUrl + endpoint
    }
}

public func prepareBody<T: Encodable>(
    with payload: T,
    strategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    ) -> Data? {
        
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    jsonEncoder.keyEncodingStrategy = strategy
    
    do {
        return try jsonEncoder.encode(payload)
    } catch {
        NetworkingLogger.logError(error: error, url: nil)
        return nil
    }
}
