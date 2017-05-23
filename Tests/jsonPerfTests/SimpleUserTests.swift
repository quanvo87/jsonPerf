import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class SimpleUserTests: XCTestCase {
    // MARK: - JSONDecoder
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                _ = try? JSONDecoder().decode(SimpleUser.self, from: sampleSimpleUserData)
            }
        }
    }   // .009s

    // MARK: - JSONSerialization
    func testJSONSerializationDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: [])
            }
        }
    }   // .002s

    func testJSONSerializationCreateStruct() {
        let json = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: []) as? [String: Any]
        self.measure {
            for _ in 0..<testRuns {
                _ = SimpleUser(json)
            }
        }
    }   // .001s

    func testJSONSerializationBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: []) as? [String: Any]
                _ = SimpleUser(json)
            }
        }
    }   // .007s

    // MARK: - SwiftyJSON
    func testSwiftyJSONDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = JSON(data: sampleSimpleUserData)
            }
        }
    }   // .006s

    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: sampleSimpleUserData)
        self.measure {
            for _ in 0..<testRuns {
                _ = SimpleUser(json)
            }
        }
    }   // .006s

    func testSwiftyJSONBBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = JSON(data: sampleSimpleUserData)
                _ = SimpleUser(json)
            }
        }
    }   // .014s
}

extension SimpleUserTests {
    func testDecoderCorrectness() {
        let user = try? JSONDecoder().decode(SimpleUser.self, from: sampleSimpleUserData)
        XCTAssertEqual(user, sampleSimpleUser)
    }

    func testJSONSerializationCorrectness() {
        let json = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: []) as? [String: Any]
        let user = SimpleUser(json)
        XCTAssertEqual(user, sampleSimpleUser)
    }

    func testSwiftyJSONCorrectness() {
        let json = JSON(data: sampleSimpleUserData)
        let user = SimpleUser(json)
        XCTAssertEqual(user, sampleSimpleUser)
    }
}
