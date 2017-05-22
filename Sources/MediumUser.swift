import Foundation
import SwiftyJSON

struct MediumUser: Codable {
    let id: String
    let name: String
    let address: Address
    let registered: Bool
}

// MARK: - JSONDeserialization
extension MediumUser {
    init?(_ d: [String: Any]??) {
        guard
            let id = d??["id"] as? String,
            let name = d??["name"] as? String,
            let address = d??["address"] as? [String: Any],
            let number = address["number"] as? Int,
            let street = address["street"] as? String,
            let type = address["type"] as? String,
            let addressType = AddressType(rawValue: type),
            let registered = d??["registered"] as? Bool
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.address = Address(number: number,
                               street: street,
                               type: addressType)
        self.registered = registered
    }
}

// MARK: - SwiftyJSON
extension MediumUser {
    init?(_ json: JSON) {
        guard
            let id = json["id"].string,
            let name = json["name"].string,
            let number = json["address"]["number"].int,
            let street = json["address"]["street"].string,
            let type = json["address"]["type"].string,
            let addressType = AddressType(rawValue: type),
            let registered = json["registered"].bool
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.address = Address(number: number,
                               street: street,
                               type: addressType)
        self.registered = registered
    }
}

// MARK: - Equatable
extension MediumUser: Equatable {
    static func ==(lhs: MediumUser, rhs: MediumUser) -> Bool {
        return  lhs.id          == rhs.id &&
                lhs.name        == rhs.name &&
                lhs.address     == rhs.address &&
                lhs.registered  == rhs.registered
    }
}
