import XCTest
import ViaCep

final class MainViewControllerTests: XCTestCase {
    private lazy var presenterSpy = MainPresenterSpy()
    private lazy var serviceSpy = MainServiceSpy()
    private lazy var interactorSpy: MainInteractor = {
        let interac = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy)
        return interac
    }()
    
    private lazy var sut: MainViewController = {
        let viewController = MainViewController(
            interactor: interactorSpy
        )
        return viewController
    }()
    
    func test_inputedCepTextField() throws {
        let cep = try XCTUnwrap(sut.inputedCepTextField.text)
        
        sut.didPresentCep(.dummy(cep: cep))
        
        XCTAssertEqual(cep, "")
    }
    
    func test_searchCepButton() throws {
        let searchCepButton: UIButton = try XCTUnwrap(sut.searchCepButton)
        let actions = try XCTUnwrap(searchCepButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        XCTAssertEqual(actions.count, 1)
        XCTAssertEqual(actions.first, "didSearchCep")
    }
    
    func test_() {
        sut.searchCepButton.sendActions(for: .touchUpInside)
    }

    func test_didPresentCep() {
        let dataObject: DataCep = .dummy()
        
        sut.didPresentCep(dataObject)
                
        XCTAssertNotNil(interactorSpy.displayCep(dataObject.cep))
        XCTAssertEqual(dataObject.logradouro, "Praça Marechal Deodoro")
        XCTAssertEqual(dataObject.bairro, "Santa Cecília")
        XCTAssertEqual(dataObject.localidade, "São Paulo")
    }
}
