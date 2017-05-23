import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class LargeTests: XCTestCase {
    // MARK: - JSONDecoder

    func testDecoder() {
        self.measure {
            let large = try? JSONDecoder().decode(Large.self, from: largeData)
            XCTAssert(large?.programList.programs.count ?? 0 > 1000)
        }
    }

    // MARK: - JSONSerialization

    func testJSONSerializationDecode() {
        self.measure {
            _ = try? JSONSerialization.jsonObject(with: largeData, options: [])
        }
    }

    func testJSONSerializationCreateStruct() {
        let dict = try? JSONSerialization.jsonObject(with: largeData, options: []) as? [String: Any]
        self.measure {
            let large = Large(dict)
            XCTAssert(large?.programList.programs.count ?? 0 > 1000)
        }
    }

    func testJSONSerializationBoth() {
        self.measure {
            let dict = try? JSONSerialization.jsonObject(with: largeData, options: []) as? [String: Any]
            let large = Large(dict)
            XCTAssert(large?.programList.programs.count ?? 0 > 1000)
        }
    }

    // MARK: - SwiftyJSON

    func testSwiftyJSONSerialization() {
        self.measure {
            _ = JSON(data: largeData)
        }
    }

    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: largeData)
        self.measure {
            let large = Large(json: json)
            XCTAssert(large.programList.programs.count > 1000)
        }
    }

    func testSwiftyJSONBoth() {
        self.measure {
            let json = JSON(data: largeData)
            let large = Large(json: json)
            XCTAssert(large.programList.programs.count > 1000)
        }
    }
}
