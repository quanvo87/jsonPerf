#if os(macOS) && swift(>=4)
    import XCTest
    import Foundation
    @testable import jsonPerf
    import SwiftyJSON

    class jsonPerfTests: XCTestCase {
        func testDecoder() throws {
            // Test correctness
            let user = try JSONDecoder().decode(User.self, from: self.sampleUserData)
            XCTAssertEqual(user, self.sampleUser)

            // Test performance
            self.measure {
                for _ in 0..<1000 {
                    // `decode()` decodes the data AND creates a `User` struct
                    _ = try! JSONDecoder().decode(User.self, from: self.sampleUserData)
                }
            }
        }

        func testSwiftyJSON() {
            // Test correctness
            let json = JSON(data: self.sampleUserData)
            guard let user = User(json) else {
                XCTFail()
                return
            }
            XCTAssertEqual(user, self.sampleUser)

            // Test performance
            self.measure {
                for _ in 0..<1000 {
                    // Decode the data
                    let json = JSON(data: self.sampleUserData)

                    // Create `User` struct from decoded data
                    _ = User(json)
                }
            }
        }

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
