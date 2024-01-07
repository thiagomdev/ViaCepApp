import UIKit

enum MainAction {
    case destination
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
        case .destination:
            break
        }
    }
}
