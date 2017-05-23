import Foundation
import SwiftyJSON

struct ComplexUser: Codable {
    let id: String
    let name: String
    let addresses: [Address]
    let registered: Bool
    let pets: [Animal]
}

// MARK: - JSONDeserialization
extension ComplexUser {
    init?(_ d: [String: Any]??) {
        guard
            let id = d??["id"] as? String,
            let name = d??["name"] as? String,
            let addresses = d??["addresses"] as? [[String: Any]],
            let registered = d??["registered"] as? Bool,
            let pets = d??["pets"] as? [[String: Any]]
            else {
                return nil
        }

        var tempAddresses = [Address]()
        for address in addresses {
            guard
                let number = address["number"] as? Int,
                let street = address["street"] as? String,
                let type = address["type"] as? String,
                let addressType = AddressType(rawValue: type)
                else {
                    return nil
            }
            let tempAddress = Address(number: number,
                                      street: street,
                                      type: addressType)
            tempAddresses.append(tempAddress)
        }

        var tempPets = [Animal]()
        for pet in pets {
            guard
                let name = pet["name"] as? String,
                let species = pet["species"] as? String,
                let speciesType = AnimalSpecies(rawValue: species),
                let diet = pet["diet"] as? [String]
                else {
                    return nil
            }

            var tempDiet = [Food]()
            for food in diet {
                guard let tempFood = Food(rawValue: food) else {
                    return nil
                }
                tempDiet.append(tempFood)
            }

            let tempPet = Animal(name: name,
                                 species: speciesType,
                                 diet: tempDiet)
            tempPets.append(tempPet)
        }

        self.id = id
        self.name = name
        self.addresses = tempAddresses
        self.registered = registered
        self.pets = tempPets
    }
}

// MARK: - SwiftyJSON
extension ComplexUser {
    init?(_ json: JSON) {
        guard
            let id = json["id"].string,
            let name = json["name"].string,
            let addresses = json["addresses"].array,
            let registered = json["registered"].bool,
            let pets = json["pets"].array
            else {
                return nil
        }

        var tempAddresses = [Address]()
        for address in addresses {
            guard
                let number = address["number"].int,
                let street = address["street"].string,
                let type = address["type"].string,
                let addressType = AddressType(rawValue: type)
                else {
                    return nil
            }
            let tempAddress = Address(number: number,
                                      street: street,
                                      type: addressType)
            tempAddresses.append(tempAddress)
        }

        var tempPets = [Animal]()
        for pet in pets {
            guard
                let name = pet["name"].string,
                let species = pet["species"].string,
                let speciesType = AnimalSpecies(rawValue: species),
                let diet = pet["diet"].array
                else {
                    return nil
            }

            var tempDiet = [Food]()
            for food in diet {
                guard
                    let foodString = food.string,
                    let tempFood = Food(rawValue: foodString)
                    else {
                        return nil
                }
                tempDiet.append(tempFood)
            }

            let tempPet = Animal(name: name,
                                 species: speciesType,
                                 diet: tempDiet)
            tempPets.append(tempPet)
        }

        self.id = id
        self.name = name
        self.addresses = tempAddresses
        self.registered = registered
        self.pets = tempPets
    }
}

// MARK: - Equatable
extension ComplexUser: Equatable {
    static func ==(lhs: ComplexUser, rhs: ComplexUser) -> Bool {
        return  lhs.id          == rhs.id &&
                lhs.name        == rhs.name &&
                lhs.addresses   == rhs.addresses &&
                lhs.registered  == rhs.registered &&
                lhs.pets        == rhs.pets
    }
}
