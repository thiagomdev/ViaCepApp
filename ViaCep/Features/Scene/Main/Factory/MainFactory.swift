import UIKit

public enum MainFactory {
    static func make() -> UIViewController {
        let service = MainService(networking: Networking())
        let presenter = MainPresenter()
        let interactor = MainInteractor(presenter: presenter, service: service)
        let viewController = MainViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
