import Foundation
import SwiftyJSON

struct SimpleUser: Codable {
    let id: String
}

// MARK: - JSONDeserialization
extension SimpleUser {
    init?(_ d: [String: Any]??) {
        guard let id = d??["id"] as? String else {
            return nil
        }
        self.id = id
    }
}

// MARK: - SwiftyJSON
extension SimpleUser {
    init?(_ json: JSON) {
        guard let id = json["id"].string else {
            return nil
        }
        self.id = id
    }
}

// MARK: - Equatable
extension SimpleUser: Equatable {
    static func ==(lhs: SimpleUser, rhs: SimpleUser) -> Bool {
        return lhs.id == rhs.id
    }
}
