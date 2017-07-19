import XCTest
import Foundation
@testable import jsonPerf

/*
 Not a performance test but showing how to map multiple potential keys into a single struct property.
 */

class MultiKeysTests: XCTestCase {
    static var allTests = [
        ("testid", testid),
        ("testID", testID),
        ("testidentification", testidentification)
    ]

    func testid() throws {
        let example = try JSONDecoder().decode(MultiKeys.self, from: id)
        XCTAssertEqual(example, correctExample)
    }

    func testID() throws {
        let example = try JSONDecoder().decode(MultiKeys.self, from: ID)
        XCTAssertEqual(example, correctExample)
    }

    func testidentification() throws {
        let example = try JSONDecoder().decode(MultiKeys.self, from: identification)
        XCTAssertEqual(example, correctExample)
    }
}

let id = "{\"id\": \"123\"}".data(using: .utf8)!
let ID = "{\"ID\": \"123\"}".data(using: .utf8)!
let identification = "{\"identification\": \"123\"}".data(using: .utf8)!

let correctExample = MultiKeys("123")
