#if os(macOS) && swift(>=4)
    import XCTest
    import Foundation
    @testable import jsonPerf
    import SwiftyJSON

    class jsonPerfTests: XCTestCase {
        func testDecoder() throws {
            // average: 0.038, relative standard deviation: 9.147%
            self.measure {
                for _ in 0..<self.testRuns {
                    // `decode()` decodes the data AND creates a `User` struct
                    _ = try! JSONDecoder().decode(User.self, from: self.sampleUserData)
                }
            }
        }

        func testSwiftyJSON() {
            // average: 0.084, relative standard deviation: 6.741%
            self.measure {
                for _ in 0..<self.testRuns {
                    // Decode the data
                    let json = JSON(data: self.sampleUserData)

                    // Create `User` struct from decoded data
                    _ = User(json)
                }
            }
        }

        func testDecoderCorrectness() throws {
            let user = try JSONDecoder().decode(User.self, from: sampleUserData)
            XCTAssertEqual(user, sampleUser)
        }

        func testSwiftyJSONCorrectness() {
            let json = JSON(data: sampleUserData)
            let user = User(json)
            XCTAssertEqual(user, sampleUser)
        }

        let testRuns = 1000

        let sampleUserData: Data = {
            let path = #file
                .characters
                .split(separator: "/", omittingEmptySubsequences: false)
                .dropLast(1)
                .map { String($0) }
                .joined(separator: "/") + "/example.json"
            let file = FileHandle(forReadingAtPath: path)!
            let data = file.readDataToEndOfFile()
            file.closeFile()

            return data
        }()

        let sampleUser = User(id: "87B65886-CCE5-498E-8110-9ED8018621CE",
                              name: "Mario",
                              address: Address(number: 123,
                                               street: "Mushroom St",
                                               type: .apartment),
                              registered: true)
    }
#endif
