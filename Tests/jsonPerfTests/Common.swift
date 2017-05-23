import Foundation
@testable import jsonPerf

let testRuns = 1000

// SimpleUser
let sampleSimpleUserData: Data = {
    let path = #file
        .characters
        .split(separator: "/", omittingEmptySubsequences: false)
        .dropLast(1)
        .map { String($0) }
        .joined(separator: "/") + "/simple.json"
    let file = FileHandle(forReadingAtPath: path)!
    let data = file.readDataToEndOfFile()
    file.closeFile()

    return data
}()

let sampleSimpleUser = SimpleUser(id: "87B65886-CCE5-498E-8110-9ED8018621CE")

// MediumUser
let sampleMediumUserData: Data = {
    let path = #file
        .characters
        .split(separator: "/", omittingEmptySubsequences: false)
        .dropLast(1)
        .map { String($0) }
        .joined(separator: "/") + "/medium.json"
    let file = FileHandle(forReadingAtPath: path)!
    let data = file.readDataToEndOfFile()
    file.closeFile()

    return data
}()

let sampleMediumUser = MediumUser(id: "87B65886-CCE5-498E-8110-9ED8018621CE",
                                  name: "Mario",
                                  address: Address(number: 123,
                                                   street: "Mushroom St",
                                                   type: .apartment),
                                  registered: true)

// ComplexUser
let sampleComplexUserData: Data = {
    let path = #file
        .characters
        .split(separator: "/", omittingEmptySubsequences: false)
        .dropLast(1)
        .map { String($0) }
        .joined(separator: "/") + "/complex.json"
    let file = FileHandle(forReadingAtPath: path)!
    let data = file.readDataToEndOfFile()
    file.closeFile()

    return data
}()

let sampleComplexUser = ComplexUser(id: "87B65886-CCE5-498E-8110-9ED8018621CE",
                                    name: "Mario",
                                    addresses: [Address(number: 123,
                                                        street: "Mushroom St",
                                                        type: .apartment),
                                                Address(number: 999,
                                                        street: "Pipe Way",
                                                        type: .business),
                                                Address(number: 123,
                                                        street: "6th St",
                                                        type: .home),
                                                Address(number: 4,
                                                        street: "Goldfield Rd",
                                                        type: .apartment),
                                                Address(number: 71,
                                                        street: "Pilgrim Avenue",
                                                        type: .business)],
                                    registered: true,
                                    pets: [Animal(name: "Toad",
                                                  species: .dog,
                                                  diet: [.steak]),
                                           Animal(name: "Bowser",
                                                  species: .cat,
                                                  diet: [.fish]),
                                           Animal(name: "Yoshi",
                                                  species: .dragon,
                                                  diet: [.steak, .fish, .people]),
                                           Animal(name: "Patty",
                                                  species: .cat,
                                                  diet: [.steak]),
                                           Animal(name: "Teresa",
                                                  species: .dragon,
                                                  diet: [.steak, .fish, .people]),
                                           Animal(name: "Genevieve",
                                                  species: .cat,
                                                  diet: [.steak]),
                                           Animal(name: "Harriet",
                                                  species: .dragon,
                                                  diet: [.steak, .fish]),
                                           Animal(name: "Anthony",
                                                  species: .dog,
                                                  diet: [.steak]),
                                           Animal(name: "Victoria",
                                                  species: .dragon,
                                                  diet: [.steak]),
                                           Animal(name: "Jessica",
                                                  species: .dog,
                                                  diet: [.steak, .fish])])

// Large
let largeData: Data = {
    let path = #file
        .characters
        .split(separator: "/", omittingEmptySubsequences: false)
        .dropLast(1)
        .map { String($0) }
        .joined(separator: "/") + "/large.json"
    let file = FileHandle(forReadingAtPath: path)!
    let data = file.readDataToEndOfFile()
    file.closeFile()

    return data
}()
