import Foundation

enum MainAction {
    case showError(String)
}

protocol MainCoordinating {
    func navigate(to destination: MainAction)
}


final class MainCoordinator {
    weak var viewController: MainViewControlling?
}

extension MainCoordinator: MainCoordinating {
    func navigate(to destination: MainAction) {
        switch destination {
        case let .showError(message):
            viewController?.didShowError(message)
        }
    }
}
