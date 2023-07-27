import Foundation

final class Tasking<T: Codable>: Task {
    let request: Request
    
    private let session = URLSession.shared
    private let callback: ((Result<T, Error>) -> Void)?
    private var task: URLSessionDataTask?
    
    init(request: Request, callback: ((Result<T, Error>) -> Void)?) {
        self.request = request
        self.callback = callback
    }
    
    func resume() {
        guard let url = URL(string: request.url) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = self.request.headers
        request.httpMethod = self.request.method.description
        request.httpBody = self.request.body
        
        task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let httpRsponse = response as? HTTPURLResponse, let data = data else { return }
            if (200..<300).contains(httpRsponse.statusCode) {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    self?.callback?(.success(decoded))
                } catch let err {
                    self?.callback?(.failure(err))
                }
            }
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
