import Foundation
@testable import ViaCep

extension MainInteractorTests {
    typealias Doubles = (
        presenterSpy: MainPresenterSpy,
        serviceSpy: ServiceMock
    )

    func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainInteractor,
        doubles: Doubles) {
        
        let serviceSpy = ServiceMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(
            presenter: presenterSpy,
            service: serviceSpy)
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: presenterSpy, file: file, line: line)
        trackForMemoryLeaks(to: serviceSpy, file: file, line: line)
        
        return (sut, (presenterSpy, serviceSpy))
    }
}
