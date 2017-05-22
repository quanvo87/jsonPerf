// swift-DEVELOPMENT-SNAPSHOT-2017-05-19-a
#if os(macOS) && swift(>=4)
    import Foundation
    import SwiftyJSON

    struct User: Codable {
        let id: String
        let name: String
        let address: Address
        let registered: Bool
    }

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

    // MARK: - SwiftyJSON
    extension User {
        init?(_ json: JSON) {
            guard
                let id = json["id"].string,
                let name = json["name"].string,
                let number = json["address"]["number"].int,
                let street = json["address"]["street"].string,
                let type = json["address"]["type"].string,
                let addressType = AddressType(rawValue: type),
                let registered = json["registered"].bool else {
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
    extension User: Equatable {
        static func ==(lhs: User, rhs: User) -> Bool {
            return  lhs.id          == rhs.id &&
                    lhs.name        == rhs.name &&
                    lhs.address     == rhs.address &&
                    lhs.registered  == rhs.registered
        }
    }

    extension Address: Equatable {
        static func ==(lhs: Address, rhs: Address) -> Bool {
            return  lhs.number  == rhs.number &&
                    lhs.street  == rhs.street &&
                    lhs.type    == rhs.type
        }
    }
#endif
