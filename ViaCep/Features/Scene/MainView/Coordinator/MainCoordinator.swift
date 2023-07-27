import Foundation

enum MainAction {
    case main
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
        case .main:
            break
        }
    }
}
