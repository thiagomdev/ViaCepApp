import UIKit

protocol MainPresenting {
    func presentCep(_ cep: DataCep)
    func displayError(_ message: String)
}

final class MainPresenter {
    weak var viewController: MainViewControlling?
    private let coordinator: MainCoordinating?
    private var dataModel: DataCep?
    
    init(coordinator: MainCoordinating?) {
        self.coordinator = coordinator
    }
}

extension MainPresenter: MainPresenting {
    func presentCep(_ cep: DataCep) {
        viewController?.didShowCep(cep)
    }
    
    func displayError(_ message: String) {
        viewController?.didShowError(message)
    }
}
