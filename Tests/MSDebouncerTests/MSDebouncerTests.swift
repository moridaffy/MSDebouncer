import XCTest
@testable import MSDebouncer

final class MSDebouncerTests: XCTestCase {
  func testDebounce() {
    var outputValue: String?
    
    let expectation = XCTestExpectation(description: "Output value updated")
    
    let debouncer = Debouncer(outputType: String.self) { latestValue in
      outputValue = latestValue
      
      expectation.fulfill()
    }
    
    debouncer.setValue("A")
    debouncer.setValue("B")
    debouncer.setValue("C")
    
    wait(for: [expectation], timeout: debouncer.debounceTime)
    XCTAssertTrue(outputValue == "C")
  }
}
