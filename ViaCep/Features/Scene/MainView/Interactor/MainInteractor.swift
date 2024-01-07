import Foundation
import Firebase

protocol MainInteracting {
    func displayCep(_ cep: String)
    func clearText() -> String?
    func displayInvalidCep(_ data: DataCep)
    
    func createUser(from email: String, password: String)
}

final class MainInteractor {
    private let presenter: MainPresenting?
    private let service: MainServicing?
    private var auth: Auth? = .auth()
    
    init(presenter: MainPresenting, service: MainServicing) {
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
                self?.presenter?.displayError(error.localizedDescription)
            }
        }
    }
    
    func clearText() -> String? {
        return nil
    }
    
    func displayInvalidCep(_ data: DataCep) {
        presenter?.displayInvalidCepAlertMessage(data)
    }
    
    func createUser(from email: String, password: String) {
        auth?.createUser(withEmail: email, password: password, completion: { result, error in
            if error != nil {
                
            } else {
                self.presenter?.creatingUser(from: email, password: password)
            }
        })
    }
}
