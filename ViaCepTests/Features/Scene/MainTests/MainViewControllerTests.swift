import XCTest
@testable import ViaCep

final class MainViewControllerTests: XCTestCase {
    func test_searchCep_callsDisplayCepOnInteractor() {
        let (sut, doubles) = makeSut()
        let dataCep = DataCep.dummy()
        let cep = dataCep.cep
        
        sut.inputedCepTextField.text = cep
        sut.searchCep()

        XCTAssertEqual(doubles.interactorSpy.displayCepExpected, [cep])
    }
}

extension MainViewControllerTests {
    private typealias Doubles = (
        interactorSpy: InteractorSpy,
        serviceMock: ServiceMock
    )
    
    private func makeSut() -> (
        sut: MainViewController,
        doubles: Doubles
    ) {
        let interactorSpy = InteractorSpy()
        let serviceMock = ServiceMock()
        let sut = MainViewController(interactor: interactorSpy)
        return (sut, (interactorSpy, serviceMock))
    }
    
    private class InteractorSpy: MainInteracting {
        private(set) var displayCepExpected: [String] = []
        private(set) var clearTextCep: String?
        private(set) var displayInvalidCepExpected: [DataCep] = []
        
        func displayCep(_ cep: String) {
            displayCepExpected.append(cep)
        }
        
        func clearText() -> String? {
            return clearTextCep
        }
        
        func displayInvalidCep(_ data: ViaCep.DataCep) {
            displayInvalidCepExpected.append(data)
        }
    }
}
