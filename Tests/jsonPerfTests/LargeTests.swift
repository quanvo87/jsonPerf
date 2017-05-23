import XCTest
import Foundation
@testable import jsonPerf
import SwiftyJSON

class LargeTests: XCTestCase {
    // MARK: - JSONDecoder
    func testDecoder() {
        self.measure {
            _ = try? JSONDecoder().decode(Large.self, from: largeData)
        }
    }   // .994s

    // MARK: - JSONSerialization
    func testJSONSerializationDecode() {
        self.measure {
            _ = try? JSONSerialization.jsonObject(with: largeData, options: [])
        }
    }   // .087s

    func testJSONSerializationCreateStruct() {
        let dict = try? JSONSerialization.jsonObject(with: largeData, options: []) as? [String: Any]
        self.measure {
            _ = Large(dict)
        }
    }   // .705s

    func testJSONSerializationBoth() {
        self.measure {
            let dict = try? JSONSerialization.jsonObject(with: largeData, options: []) as? [String: Any]
            _ = Large(dict)
        }
    }   // .825s

    // MARK: - SwiftyJSON
    func testSwiftyJSONSerialization() {
        self.measure {
            _ = JSON(data: largeData)
        }
    }   // .093s

    func testSwiftyJSONCreateStruct() {
        let json = JSON(data: largeData)
        self.measure {
            _ = Large(json: json)
        }
    }   // 1.020s

    func testSwiftyJSONBoth() {
        self.measure {
            let json = JSON(data: largeData)
            _ = Large(json: json)
        }
    }   // 1.087s
}

extension LargeTests {
    func testDecoderCorrectness() {
        let large = try? JSONDecoder().decode(Large.self, from: largeData)
        XCTAssert(large?.programList.programs.count ?? 0 == 4710)
    }

    func testJSONSerializationCorrectness() {
        let dict = try? JSONSerialization.jsonObject(with: largeData, options: []) as? [String: Any]
        let large = Large(dict)
        XCTAssert(large?.programList.programs.count ?? 0 == 4710)
    }

    func testSwiftyJSONCorrectness() {
        let json = JSON(data: largeData)
        let large = Large(json: json)
        XCTAssert(large.programList.programs.count == 4710)
    }
}
