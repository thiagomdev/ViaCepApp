import XCTest
@testable import ViaCep

final class MainViewControllerTests: XCTestCase {
    
    func test_SearchCep_CallsDisplayCepOnInteractor() {
        let (sut, interactorSpy, _) = makeSut()
        let dataCep = DataCep.dummy()
        let cep = dataCep.cep
        
        sut.inputedCepTextField.text = cep
        sut.searchCep()

        XCTAssertEqual(interactorSpy.displayCepExpected, cep)
    }
}

final class InteractorSpy: MainInteracting {
    private(set) var displayCepExpected: String?
    private(set) var clearTextCep: String?
    private(set) var displayInvalidCepExpected: DataCep?
    
    func displayCep(_ cep: String) {
        displayCepExpected = cep
    }
    
    func clearText() -> String? {
        return clearTextCep
    }
    
    func displayInvalidCep(_ data: ViaCep.DataCep) {
        displayInvalidCepExpected = data
    }
}

extension MainViewControllerTests {
    private func makeSut() -> (
        sut: MainViewController,
        interactorSpy: InteractorSpy,
        serviceMock: ServiceMock
    ) {
        let interactorSpy = InteractorSpy()
        let serviceMock = ServiceMock()
        let sut = MainViewController(interactor: interactorSpy)
        return (sut, interactorSpy, serviceMock)
    }
}
