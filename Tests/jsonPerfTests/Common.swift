import Foundation
@testable import jsonPerf

let testRuns = 1000

let largeData: Data = {
    let path = URL(fileURLWithPath: #file).appendingPathComponent("../large.json").standardized.path
    let file = FileHandle(forReadingAtPath: path)!
    let data = file.readDataToEndOfFile()
    file.closeFile()
    return data
}()
