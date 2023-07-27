import Foundation

protocol MainServicing {
    func getCep(_ cep: String, callback: @escaping (Result<DataCep, Error>) -> Void)
}

final class MainService {
    // MARK: - Properties
    private var task: Task?
    private let networking: NetworkingProtocol
    
    // MARK: - Initializers
    init(
        networking: NetworkingProtocol = Networking()
    ) {
        self.networking = networking
    }
}

// MARK: - MainServicingProtocol
extension MainService: MainServicing {
    func getCep(_ cep: String, callback: @escaping (Result<DataCep, Error>) -> Void) {
        task = networking.execute(request: MainAPIRequest.cep(cep), responseType: DataCep.self, callback: { result in
            switch result {
            case let .success(model):
                callback(.success(model))
            case let .failure(err):
                callback(.failure(err))
            }
        })
        task?.resume()
    }
}


