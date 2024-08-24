import UIKit

public protocol MainPresenting {
    func presentCep(_ cep: DataCep)
    func displayError(_ message: String)
}

public final class MainPresenter {
    public weak var viewController: MainViewControlling?
    
    public init() {}
}

extension MainPresenter: MainPresenting {
    public func presentCep(_ cep: DataCep) {
        viewController?.didPresentCep(cep)
    }
    
    public func displayError(_ message: String) {
        viewController?.didShowErrorMessage(message)
    }
}
