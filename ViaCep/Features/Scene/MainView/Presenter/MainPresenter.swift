import UIKit
// MARK: - MainPresenting / Protocol
protocol MainPresenting {
    func presentCep(_ cep: DataCep)
    func displayError(_ message: String)
    func displayInvalidCepAlertMessage(_ data: DataCep)
}

final class MainPresenter {
    // MARK: - Properties
    weak var viewController: MainViewControlling?
    private let coordinator: MainCoordinating?
    
    // MARK: - Initializers
    init(coordinator: MainCoordinating?) {
        self.coordinator = coordinator
    }
}

// MARK: - MainPresenting / Protocol
extension MainPresenter: MainPresenting {
    func presentCep(_ cep: DataCep) {
        viewController?.didShowCep(cep)
    }
    
    func displayError(_ message: String) {
        viewController?.didShowError(message)
    }
    
    func displayInvalidCepAlertMessage(_ data: DataCep) {
        if data.cep.count >= 8 {
            viewController?.didDisplayInvalidCepMessage(data.cep)
        }
    }
}
