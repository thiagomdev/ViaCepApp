import Foundation
// MARK: - MainInteracting / Protocol
protocol MainInteracting {
    func showCep(_ cep: String)
    func clearText() -> String?
}

final class MainInteractor {
    // MARK: - Properties
    private let presenter: MainPresenting?
    private let service: MainServicing?
    
    // MARK: - Initializers
    init(presenter: MainPresenting, service: MainServicing) {
        self.presenter = presenter
        self.service = service
    }
}

// MARK: - MainInteracting / Protocol
extension MainInteractor: MainInteracting {
    func showCep(_ cep: String) {
        service?.getCep(cep, callback: { [weak self] result in
            switch result {
            case let .success(cep):
                self?.presenter?.presentCep(cep)
            case let .failure(error):
                self?.presenter?.displayError(error.localizedDescription)
            }
        })
    }
    
    func clearText() -> String? {
        return nil
    }
}
