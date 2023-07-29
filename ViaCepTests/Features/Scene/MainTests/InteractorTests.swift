import XCTest
@testable import ViaCep

final class InteractorTests: XCTestCase {
    typealias DataCepMock = DataCep
    
    func test_ShowCep_WhenTheServiceSearchAValidCep_ShouldReturnAValidCep() {
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let data = DataCepMock.fixture()
        
        serviceSpy.expexted = .success(data)
        sut.showCep(data.cep)
        
        XCTAssertEqual(presenterSpy.wasCalled, true)
        XCTAssertEqual(presenterSpy.howManyTimes, 1)
        XCTAssertEqual(presenterSpy.expected, "01150011")
    }
    
    func test_Failure() {
        let (sut, presenterSpy, serviceSpy) = makeSut()
        let data = DataCepMock.fixture()
        let error = NSError(domain: "", code: 0, userInfo: nil)

        serviceSpy.expexted = .failure(error)
        sut.showCep(data.cep)
        
        XCTAssertEqual(presenterSpy.wasCalled, true)
        XCTAssertEqual(presenterSpy.howManyTimes, 1)
    }
    
    func test_ClearText_WhenNeedToClearText_ShouldReturnNilToClearAllOfThen() {
        let (sut, presenterSpy, _) = makeSut()
        
        let expected = sut.clearText()

        XCTAssertEqual(presenterSpy.expected, expected)
    }
    
    func test_DisplayInvalidCep() {
        let (sut, presenterSpy, _) = makeSut()
        let data: DataCepMock = .fixture()
        
        sut.displayInvalidCep(data)

        XCTAssertEqual(presenterSpy.wasCalled, true)
        XCTAssertEqual(presenterSpy.howManyTimes, 1)
        XCTAssertEqual(presenterSpy.dataModelExpected, data)
    }
    
    private func makeSut() -> (
        sut: MainInteractor,
        presenterSpy: InteractorSpy,
        serviceSpy: ServiceMock
    ) {
        
        let serviceSpy = ServiceMock()
        let presenterSpy = InteractorSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy
        )
        return (sut, presenterSpy, serviceSpy)
    }
}
