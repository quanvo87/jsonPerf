import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class MediumUserTests: XCTestCase {
    // MARK: - JSONDecoder
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                _ = try? JSONDecoder().decode(MediumUser.self, from: sampleMediumUserData)
            }
        }
    }   // .038s

    // MARK: - JSONSerialization
    func testJSONSerializationDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: [])
            }
        }
    }   // .004s

    func testJSONSerializationCreateStruct() {
        let json = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]
        self.measure {
            for _ in 0..<testRuns {
                _ = MediumUser(json)
            }
        }
    }   // .013s

    func testJSONSerializationBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]
                _ = MediumUser(json)
            }
        }
    }   // .030s

    // MARK: - SwiftyJSON
    func testSwiftyJSONDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = JSON(data: sampleMediumUserData)
            }
        }
    }   // .015s

    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: sampleMediumUserData)
        self.measure {
            for _ in 0..<testRuns {
                _ = MediumUser(json)
            }
        }
    }   // .075s

    func testSwiftyJSONBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = JSON(data: sampleMediumUserData)
                _ = MediumUser(json)
            }
        }
    }   // .109s
}

extension MediumUserTests {
    func testDecoderCorrectness() {
        let user = try? JSONDecoder().decode(MediumUser.self, from: sampleMediumUserData)
        XCTAssertEqual(user, sampleMediumUser)
    }

    func testJSONSerializationCorrectness() {
        let json = try? JSONSerialization.jsonObject(with: sampleMediumUserData, options: []) as? [String: Any]
        let user = MediumUser(json)
        XCTAssertEqual(user, sampleMediumUser)
    }

    func testSwiftyJSONCorrectness() {
        let json = JSON(data: sampleMediumUserData)
        let user = MediumUser(json)
        XCTAssertEqual(user, sampleMediumUser)
    }
}
