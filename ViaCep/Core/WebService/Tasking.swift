import Foundation

enum NetworkError: Error {
    case responseError(Data?, Int)
}

struct EmptyResponse: Decodable {
    init() {
        
    }
}

final class Tasking<T: Codable>: Task {
    let request: Request
    
    private let session = URLSession.shared
    private let callback: ((Result<T, Error>) -> Void)?
    private var task: URLSessionDataTask?
    private let responseType: T.Type
    
    init(
        request: Request,
        callback: ((Result<T, Error>) -> Void)?,
        responseType: T.Type
    ) {
        self.request = request
        self.callback = callback
        self.responseType = responseType
    }
    
    func resume() {
        guard let url = URL(string: request.url) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = self.request.headers
        print("DEBUG: Headers -> \(self.request.headers ?? [:])")
        
        request.httpMethod = self.request.method.description
        print("DEBUG: Method -> \(self.request.method.description)")
        
        request.httpBody = self.request.body
        print("DEBUG: Body -> \(self.request.body ?? Data())")
        
        task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data),
                   let printData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                   let text = String(data: printData, encoding: .utf8)  {
                    print("DEBUG: Text -> \(text)")
                }
            }
            
            if let error = error {
                self?.callback?(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("DEBUD: Status code -> \(httpResponse.statusCode)")
            
            if (200..<300).contains(httpResponse.statusCode), let data = data {
                if self?.responseType is EmptyResponse.Type, let decoded = EmptyResponse() as? T {
                    self?.callback?(.success(decoded))
                } else {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        self?.callback?(.success(decoded))
                        
                    } catch let error {
                        self?.callback?(.failure(error))
                    }
                }
            } else {
                self?.callback?(
                    .failure(
                        NetworkError.responseError(
                            data, httpResponse.statusCode))
                )
            }
        })
                                          
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
