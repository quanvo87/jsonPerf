import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class ComplexUserTests: XCTestCase {
    // MARK: - JSONDecoder

    // 0.392 sec
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                let user = try? JSONDecoder().decode(ComplexUser.self, from: sampleComplexUserData)
                XCTAssertEqual(user, sampleComplexUser)
            }
        }
    }

    // MARK: - JSONSerialization

    // 0.027 sec
    func testJSONSerializationDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]
            }
        }
    }

    // 0.185 sec
    func testJSONSerializationCreateStruct() {
        let json = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]

        self.measure {
            for _ in 0..<testRuns {
                _ = ComplexUser(json)
            }
        }
    }

    // 0.242 sec
    func testJSONSerializationBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]
                let user = ComplexUser(json)
                XCTAssertEqual(user, sampleComplexUser)
            }
        }
    }

    // MARK: - SwiftyJSON

    // 0.029 sec
    func testSwiftyJSONDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = JSON(data: sampleComplexUserData)
            }
        }
    }

    // 0.512 sec
    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: sampleComplexUserData)

        self.measure {
            for _ in 0..<testRuns {
                _ = ComplexUser(json)
            }
        }
    }

    // 0.577 sec
    func testSwiftyJSONBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = JSON(data: sampleComplexUserData)
                let user = ComplexUser(json)
                XCTAssertEqual(user, sampleComplexUser)
            }
        }
    }
}
