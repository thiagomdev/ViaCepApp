import UIKit

protocol MainPresenting {
    func presentCep(_ cep: DataCep)
    func displayError(_ message: String)
}

final class MainPresenter {
    weak var viewController: MainViewControlling?
}

extension MainPresenter: MainPresenting {
    func presentCep(_ cep: DataCep) {
        viewController?.didPresentCep(cep)
    }
    
    func displayError(_ message: String) {
        viewController?.didShowErrorMessage(message)
    }
}
