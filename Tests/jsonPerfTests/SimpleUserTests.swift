import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class SimpleUserTests: XCTestCase {
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

    // 0.009 sec
    func testJSONDeserialization() {
        self.measure {
            for _ in 0..<testRuns {
                // Decode the data
                let json = try? JSONSerialization.jsonObject(with: sampleSimpleUserData, options: []) as? [String: Any]

                // Create `User` struct from decoded data
                let user = SimpleUser(json)
                XCTAssertEqual(user, sampleSimpleUser)
            }
        }
    }

    // 0.016 sec
    func testSwiftyJSON() {
        self.measure {
            for _ in 0..<testRuns {
                // Decode the data
                let json = JSON(data: sampleSimpleUserData)

                // Create `User` struct from decoded data
                let user = SimpleUser(json)
                XCTAssertEqual(user, sampleSimpleUser)
            }
        }
    }
}
