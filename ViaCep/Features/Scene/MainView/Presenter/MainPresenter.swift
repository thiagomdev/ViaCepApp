import Foundation

protocol MainPresenting {
    func presentCep(_ cep: DataCep)
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
}
