import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class MediumUserTests: XCTestCase {
    // 0.044 sec
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                let user = try? JSONDecoder().decode(MediumUser.self, from: sampleMediumUserData)
                XCTAssertEqual(user, sampleMediumUser)
            }
        }
    }

    // 0.034 sec
    func testJSONDeserialization() {
        self.measure {
            for _ in 0..<testRuns {
                // Decode the data
                let json = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]

                // Create `User` struct from decoded data
                let user = MediumUser(json)
                XCTAssertEqual(user, sampleMediumUser)
            }
        }
    }

    // 0.095 sec
    func testSwiftyJSON() {
        self.measure {
            for _ in 0..<testRuns {
                // Decode the data
                let json = JSON(data: sampleMediumUserData)

                // Create `User` struct from decoded data
                let user = MediumUser(json)
                XCTAssertEqual(user, sampleMediumUser)
            }
        }
    }
}
