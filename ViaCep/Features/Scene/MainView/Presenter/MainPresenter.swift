import UIKit

protocol MainPresenting {
    func presentCep(_ cep: DataCep)
    func displayError(_ message: String)
    func displayInvalidCepAlertMessage(_ data: DataCep)
    
    func creatingUser(from email: String, password: String)
}

final class MainPresenter {
    weak var viewController: MainViewControlling?
    private let coordinator: MainCoordinating?
    
    init(coordinator: MainCoordinating?) {
        self.coordinator = coordinator
    }
}

extension MainPresenter: MainPresenting {
    func presentCep(_ cep: DataCep) {
        viewController?.didPresentCep(cep)
    }
    
    func displayError(_ message: String) {
        viewController?.didShowErrorMessage(message)
    }
    
    func displayInvalidCepAlertMessage(_ data: DataCep) {
        if data.cep.count >= 8 {
            viewController?.didDisplayInvalidCepMessage(data.cep)
        }
    }
    
    func creatingUser(from email: String, password: String) {
        viewController?.didCreateUser(from: email, password: password)
    }
}
