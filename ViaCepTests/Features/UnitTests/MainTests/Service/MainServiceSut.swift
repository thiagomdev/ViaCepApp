import Foundation
@testable import ViaCep

extension MainServiceTests {
    typealias Doubles = (
        serviceSpy: MainServiceSpy,
        networkingSpy: NetworkingSpy
    )
    
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (
        sut: MainServicing,
        doubles: Doubles) {
            
        let networkingSpy = NetworkingSpy()
        let serviceSpy = MainServiceSpy()
        let sut = MainService(networking: networkingSpy)
        
        trackForMemoryLeaks(to: sut, file: file, line: line)
        trackForMemoryLeaks(to: serviceSpy, file: file, line: line)
        trackForMemoryLeaks(to: networkingSpy, file: file, line: line)
        
        return (sut, (serviceSpy, networkingSpy))
    }
}
