import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class ComplexUserTests: XCTestCase {
    // 0.418 sec
    func testDecoder() throws {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                let user = try? JSONDecoder().decode(ComplexUser.self, from: sampleComplexUserData)
                XCTAssertEqual(user, sampleComplexUser)
            }
        }
    }

    // 0.260 sec
    func testJSONDeserialization() {
        self.measure {
            for _ in 0..<testRuns {
                // Decode the data
                let json = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]

                // Create `User` struct from decoded data
                let user = ComplexUser(json)
                XCTAssertEqual(user, sampleComplexUser)
            }
        }
    }

    // 0.595 sec
    func testSwiftyJSON() {
        self.measure {
            for _ in 0..<testRuns {
                // Decode the data
                let json = JSON(data: sampleComplexUserData)

                // Create `User` struct from decoded data
                let user = ComplexUser(json)
                XCTAssertEqual(user, sampleComplexUser)
            }
        }
    }
}
