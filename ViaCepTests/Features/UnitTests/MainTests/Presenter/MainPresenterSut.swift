import Foundation
@testable import ViaCep

extension MainPresenterTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainPresenting,
        viewControllerSpy: MainViewControllerSpy
    ) {
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: viewControllerSpy, file: file, line: line)
        
        return (sut, viewControllerSpy)
    }
}
