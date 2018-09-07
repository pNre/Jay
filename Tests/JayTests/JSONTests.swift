import XCTest
@testable import Jay

final class JSONTests: XCTestCase {

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    func testPass() {
        guard let paths = Bundle(for: type(of: self)).urls(forResourcesWithExtension: "json", subdirectory: nil) else {
            XCTFail("Couldn't load test files")
            return
        }

        paths
            .filter { $0.lastPathComponent.hasPrefix("pass") }
            .forEach { url in
                do {
                    let data = try Data(contentsOf: url)
                    _ = try decoder.decode(JSON.self, from: data)
                } catch let error {
                    XCTFail("\(url.lastPathComponent) failed: \(error)")
                }
            }
    }

    func testFail() {
        guard let paths = Bundle(for: type(of: self)).urls(forResourcesWithExtension: "json", subdirectory: nil) else {
            XCTFail("Couldn't load test files")
            return
        }

        paths
            .filter { $0.lastPathComponent.hasPrefix("fail") }
            .forEach { url in
                let data: Data

                do {
                    data = try Data(contentsOf: url)
                    XCTAssertThrowsError(try decoder.decode(JSON.self, from: data), "\(url.lastPathComponent) passed")
                } catch let error {
                    XCTFail("\(url.lastPathComponent) failed: \(error)")
                    return
                }

            }
    }

    static var allTests = [
        ("testPass", testPass),
        ("testFail", testFail)
    ]
}
