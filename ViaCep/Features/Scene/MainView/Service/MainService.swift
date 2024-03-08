import Foundation

protocol MainServicing {
    func fetchDataCep(_ cep: String, callback: @escaping (Result<DataCep, Error>) -> Void)
}

final class MainService {
    private var task: Task?
    private let networking: NetworkingProtocol
    
    init(
        networking: NetworkingProtocol = Networking()
    ) {
        self.networking = networking
    }
}

extension MainService: MainServicing {
    func fetchDataCep(
        _ cep: String,
        callback: @escaping (Result<DataCep, Error>) -> Void
    ) {
        task = networking.execute(
            request: MainAPIRequest.cep(cep),
            responseType: DataCep.self,
            callback: { result in
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
