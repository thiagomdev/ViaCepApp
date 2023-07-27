import XCTest
@testable import ViaCep

final class PresenterTests: XCTestCase {
    
    func test_PresentCep_WhenGetsAllOfInformationData_ShouldReturnDataCep() {
        // Given
        let (sut, viewControllerSpy) = makeSut()
        
        // When
        sut.presentCep(.fixture())
        
        // Then
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.expected, .fixture())
    }
    
    private func makeSut() -> (sut: MainPresenter, viewControllerSpy: ViewControllerSpy) {
        let coordinator = MainCoordinator()
        let viewControllerSpy = ViewControllerSpy()
        let sut = MainPresenter(coordinator: coordinator)
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
}

final class ViewControllerSpy: MainViewControlling {
    private(set) var wasCalled: Bool = false
    private(set) var howManyTimes: Int = 0
    var expected: DataCep?
    
    func didShowCep(_ cep: ViaCep.DataCep) {
        wasCalled = true
        howManyTimes += 1
        expected = cep
    }
}
