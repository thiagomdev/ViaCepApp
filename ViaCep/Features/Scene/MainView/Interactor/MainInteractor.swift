import Foundation

protocol MainInteracting {
    func displayCep(_ cep: String)
    func clearText() -> String?
    func displayInvalidCep(_ data: DataCep)
}

final class MainInteractor {
    private let presenter: MainPresenting?
    private let service: MainServicing?
    
    init(
        presenter: MainPresenting,
        service: MainServicing
    ) {
        self.presenter = presenter
        self.service = service
    }
}

extension MainInteractor: MainInteracting {
    func displayCep(_ cep: String) {
        service?.fetchDataCep(cep) { [weak self] result in
            switch result {
            case let .success(cep):
                self?.presenter?.presentCep(cep)
            case let .failure(error):
                self?.presenter?.displayError(
                    error.localizedDescription
                )
            }
        }
    }
    
    func clearText() -> String? {
        return nil
    }
    
    func displayInvalidCep(_ data: DataCep) {
        presenter?.displayInvalidCepAlertMessage(data)
    }
}
