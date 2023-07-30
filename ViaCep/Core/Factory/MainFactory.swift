import UIKit

enum MainFactory {
    static func make() -> UIViewController {
        let service = MainService()
        let coordinator = MainCoordinator()
        let presenter = MainPresenter(coordinator: coordinator)
        let interactor = MainInteractor(presenter: presenter, service: service)
        let viewController = MainViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
