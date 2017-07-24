import XCTest
import Foundation
@testable import jsonPerf

class LargeTests: XCTestCase {
    static var allTests = [
        ("testDecoder", testDecoder),
        ("testJSONSerializationDecode", testJSONSerializationDecode),
        ("testJSONSerializationCreateStruct", testJSONSerializationCreateStruct),
        ("testJSONSerializationBoth", testJSONSerializationBoth),
        ("testDecoderCorrectness", testDecoderCorrectness),
        ("testJSONSerializationCorrectness", testJSONSerializationCorrectness)
    ]

    let decoder = JSONDecoder()
}

// MARK: - JSONDecoder
extension LargeTests {
    func testDecoder() {
        self.measure {
            _ = try? self.decoder.decode(Large.self, from: largeData)
        }
    }   // .994s

    func testDecoderCorrectness() {
        let large = try? decoder.decode(Large.self, from: largeData)
        XCTAssert(large?.programList.programs.count ?? 0 == 4710)
    }
}

// MARK: - JSONSerialization
extension LargeTests {
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

    func testJSONSerializationCorrectness() {
        let dict = try? JSONSerialization.jsonObject(with: largeData, options: []) as? [String: Any]
        let large = Large(dict)
        XCTAssert(large?.programList.programs.count ?? 0 == 4710)
    }
}

let largeData: Data = {
    let path = URL(fileURLWithPath: #file).appendingPathComponent("../large.json").standardized.path
    let file = FileHandle(forReadingAtPath: path)!
    let data = file.readDataToEndOfFile()
    file.closeFile()
    return data
}()
