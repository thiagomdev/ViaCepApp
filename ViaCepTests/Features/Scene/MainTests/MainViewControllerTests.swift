import XCTest
@testable import ViaCep

final class MainViewControllerTests: XCTestCase {
    func test_searchCep_callsDisplayCepOnInteractor() {
        let (sut, doubles) = makeSut()
        let dataCep = DataCep.fixture()
        let cep = dataCep.cep
        
        sut.inputedCepTextField.text = cep
        sut.searchCep()
        XCTAssertEqual(
            doubles.interactorSpy.messages, [
                .displayCep(cep: cep)]
        )
    }
    
    func test_didClearText() {
        let (sut, doubles) = makeSut()
        
        sut.didClearText()
        
        XCTAssertEqual(doubles.interactorSpy.messages, [.clearText])
        XCTAssertNil(doubles.interactorSpy.clearTextCep)
    }
    
    func test_didDisplayInvalidCepMessage() {
        let (sut, doubles) = makeSut()
        let dataCep = DataCep.fixture()
        let cep = dataCep.cep
        
        sut.didDisplayInvalidCepMessage(cep)
        
        XCTAssertEqual(
            doubles.interactorSpy.messages, [
                .displayInvalidCep(data: .fixture(cep: "01150-011"))]
        )
    }
}

extension MainViewControllerTests {
    private typealias Doubles = (
        interactorSpy: InteractorSpy,
        serviceMock: ServiceMock
    )
    
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (
        sut: MainViewController,
        doubles: Doubles
    ) {
        let interactorSpy = InteractorSpy()
        let serviceMock = ServiceMock()
        let sut = MainViewController(interactor: interactorSpy)
        trackForMemoryLeaks(to: sut)
        trackForMemoryLeaks(to: interactorSpy)
        trackForMemoryLeaks(to: serviceMock)
        return (sut, (interactorSpy, serviceMock))
    }
    
    enum Message: Hashable {
        case displayCep(cep: String)
        case clearText
        case displayInvalidCep(data: ViaCep.DataCep)
    }
    
    private class InteractorSpy: MainInteracting {
        private(set) var clearTextCep: String?
        private(set) var messages = Set<Message>()
        
        func displayCep(_ cep: String) {
            messages.insert(.displayCep(cep: cep))
        }
        
        func clearText() -> String? {
            messages.insert(.clearText)
            return clearTextCep
        }
        
        func displayInvalidCep(_ data: ViaCep.DataCep) {
            messages.insert(.displayInvalidCep(data: data))
        }
    }
}
