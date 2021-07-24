    import XCTest
    @testable import GoogleFontAPI

    final class GoogleFontAPITests: XCTestCase {
        func testFetchAllFonts() {
            let api = GoogleFontAPI()
            let expectation = XCTestExpectation(description: "fetch fonts")
            api.fetchAllFonts { result in
                switch result {
                case .success(let fonts):
                    XCTAssertFalse(fonts.isEmpty)
                case .failure(let error):
                    debugPrint(error)
                    XCTFail()
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 5)
        }
    }
