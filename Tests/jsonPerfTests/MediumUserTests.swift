import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class MediumUserTests: XCTestCase {
    // MARK: - JSONDecoder

    // 0.042 sec
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                let user = try? JSONDecoder().decode(MediumUser.self, from: sampleMediumUserData)
                XCTAssertEqual(user, sampleMediumUser)
            }
        }
    }

    // MARK: - JSONSerialization

    // 0.015 sec
    func testJSONSerializationDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]
            }
        }
    }

    // 0.013 sec
    func testJSONSerializationCreateStruct() {
        let json = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]

        self.measure {
            for _ in 0..<testRuns {
                _ = MediumUser(json)
            }
        }
    }

    // 0.033 sec
    func testJSONSerializationBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]
                let user = MediumUser(json)
                XCTAssertEqual(user, sampleMediumUser)
            }
        }
    }

    // MARK: - SwiftyJSON

    // 0.016 sec
    func testSwiftyJSONDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = JSON(data: sampleMediumUserData)
            }
        }
    }

    // 0.068 sec
    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: sampleMediumUserData)

        self.measure {
            for _ in 0..<testRuns {
                _ = MediumUser(json)
            }
        }
    }

    // 0.097 sec
    func testSwiftyJSONBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = JSON(data: sampleMediumUserData)
                let user = MediumUser(json)
                XCTAssertEqual(user, sampleMediumUser)
            }
        }
    }
}
