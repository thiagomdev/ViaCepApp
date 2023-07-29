import XCTest
@testable import ViaCep

final class ViewControllerTests: XCTestCase {
    // TODO: - FAZER O TESTE CORRETAMENTE
    typealias DataCepMock = DataCep
    
    func test_() {
        let (sut, interactorSpy, _) = makeSut()
//        let data: DataCepMock = .fixture()
        var errorMessage: String? = nil
//        serviceMock.expexted = .success(data)
        
//        sut.didShowCep(data)
        sut.didDisplayInvalidCepMessage(errorMessage ?? "")
        
//        XCTAssertEqual(interactorSpy.wasCalled, true)
//        XCTAssertEqual(interactorSpy.howManyTimes, 1)
        XCTAssertEqual(interactorSpy.expected, errorMessage)
    }
    
    private func makeSut() -> (sut: MainViewController, interactorSpy: InteractorSpy, serviceMock: ViewControllerServiceMock) {
        let serviceMock = ViewControllerServiceMock()
        let coordinator = MainCoordinator()
        let interactorSpy = InteractorSpy()
        let presenter = MainPresenter(coordinator: coordinator)
        let interactor = MainInteractor(presenter: presenter, service: serviceMock)
        let sut = MainViewController(interactor: interactor)
        
        presenter.viewController = sut
        return (sut, interactorSpy, serviceMock)
    }
}

final class InteractorSpy: MainViewControlling {
    
    private(set) var wasCalled: Bool =  false
    private(set) var howManyTimes: Int = 0
    private(set) var expected: String?
    private(set) var dataModelExpected: DataCep?
    
    func didShowCep(_ cep: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        dataModelExpected = cep
    }
    
    func didShowError(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        expected = message
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        wasCalled = true
        howManyTimes += 1
        expected = message
    }
}

final class ViewControllerServiceMock: MainServicing {
    var expexted: (Result<ViaCep.DataCep, Error>)?
    
    private(set) var wasCalled: Bool =  false
    private(set) var howManyTimes: Int = 0
    
    func getCep(_ cep: String, callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        guard let expexted = expexted else { return }
        wasCalled = true
        howManyTimes += 1
        callback(expexted)
    }
}
