import XCTest
import Combine
@testable import GoogleFontAPI

final class GoogleFontAPITests: XCTestCase {
    var api: GoogleFontAPI!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        api = GoogleFontAPI(apiKey: GoogleFontAPIKey)
        cancellables = []
    }

    func testFetchAllFonts() {
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

    func testFetchAllFontsCombine() {
        let expectation = XCTestExpectation(description: "fetch fonts")
        api.fetchAllFonts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    debugPrint(error)
                    XCTFail()
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { fonts in
                XCTAssertFalse(fonts.isEmpty)
            })
            .store(in: &cancellables)
    }
}
