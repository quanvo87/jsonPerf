import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class ComplexUserTests: XCTestCase {
    // MARK: - JSONDecoder
    func testDecoder() {
        self.measure {
            for _ in 0..<testRuns {
                // `decode()` decodes the data AND creates a `User` struct
                _ = try? JSONDecoder().decode(ComplexUser.self, from: sampleComplexUserData)
            }
        }
    }   // .357s

    // MARK: - JSONSerialization
    func testJSONSerializationDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: [])
            }
        }
    }   // .017s

    func testJSONSerializationCreateStruct() {
        let json = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]
        self.measure {
            for _ in 0..<testRuns {
                _ = ComplexUser(json)
            }
        }
    }   // .179s

    func testJSONSerializationBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]
                _ = ComplexUser(json)
            }
        }
    }   // .210s

    // MARK: - SwiftyJSON
    func testSwiftyJSONDecode() {
        self.measure {
            for _ in 0..<testRuns {
                _ = JSON(data: sampleComplexUserData)
            }
        }
    }   // .033s

    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: sampleComplexUserData)
        self.measure {
            for _ in 0..<testRuns {
                _ = ComplexUser(json)
            }
        }
    }   // .519s

    func testSwiftyJSONBoth() {
        self.measure {
            for _ in 0..<testRuns {
                let json = JSON(data: sampleComplexUserData)
                _ = ComplexUser(json)
            }
        }
    }   // .529s
}

extension ComplexUserTests {
    func testDecoderCorrectness() {
        let user = try? JSONDecoder().decode(ComplexUser.self, from: sampleComplexUserData)
        XCTAssertEqual(user, sampleComplexUser)
    }

    func testJSONSerializationCorrectness() {
        let json = try? JSONSerialization.jsonObject(with: sampleComplexUserData, options: []) as? [String: Any]
        let user = ComplexUser(json)
        XCTAssertEqual(user, sampleComplexUser)
    }

    func testSwiftyJSONCorrectness() {
        let json = JSON(data: sampleComplexUserData)
        let user = ComplexUser(json)
        XCTAssertEqual(user, sampleComplexUser)
    }
}
