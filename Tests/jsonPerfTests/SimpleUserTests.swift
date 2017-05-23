import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class SimpleUserTests: XCTestCase {
    // MARK: - JSONDecoder

    // 0.011 sec
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                let user = try? JSONDecoder().decode(SimpleUser.self, from: sampleSimpleUserData)
                XCTAssertEqual(user, sampleSimpleUser)
            }
        }
    }

    // MARK: - JSONSerialization

    // 0.006 sec
    func testJSONSerializationDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: [])
            }
        }
    }

    // 0.001 sec
    func testJSONSerializationCreateStruct() {
        let json = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: []) as? [String: Any]

        self.measure {
            for _ in 0..<testRuns {
                _ = SimpleUser(json)
            }
        }
    }

    // 0.010 sec
    func testJSONSerializationBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: []) as? [String: Any]
                let user = SimpleUser(json)
                XCTAssertEqual(user, sampleSimpleUser)
            }
        }
    }

    // MARK: - SwiftyJSON

    // 0.006 sec
    func testSwiftyJSONDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = JSON(data: sampleSimpleUserData)
            }
        }
    }

    // 0.006 sec
    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: sampleSimpleUserData)

        self.measure {
            for _ in 0..<testRuns {
                _ = SimpleUser(json)
            }
        }
    }

    // 0.016 sec
    func testSwiftyJSONBBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = JSON(data: sampleSimpleUserData)
                let user = SimpleUser(json)
                XCTAssertEqual(user, sampleSimpleUser)
            }
        }
    }
}
