import Foundation

struct Address: Codable {
    let number: Int
    let street: String
    let type: AddressType
}

enum AddressType: String, Codable {
    case home
    case apartment
    case business
}

struct Animal: Codable {
    let name: String
    let species: AnimalSpecies
    let diet: [Food]
}

enum AnimalSpecies: String, Codable {
    case dog
    case cat
    case dragon
}

enum Food: String, Codable {
    case steak
    case fish
    case people
}

// MARK: Equatable
extension Address: Equatable {
    static func ==(lhs: Address, rhs: Address) -> Bool {
        return  lhs.number  == rhs.number &&
                lhs.street  == rhs.street &&
                lhs.type    == rhs.type
    }
}

extension Animal: Equatable {
    static func ==(lhs: Animal, rhs: Animal) -> Bool {
        return  lhs.name    == rhs.name &&
                lhs.species == rhs.species &&
                lhs.diet    == rhs.diet
    }
}
