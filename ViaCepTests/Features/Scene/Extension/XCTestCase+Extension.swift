import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(to
        instance: AnyObject,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak."
            )
        }
    }
}