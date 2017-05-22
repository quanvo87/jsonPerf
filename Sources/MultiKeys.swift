import Foundation

struct MultiKeys: Decodable, Equatable {
    var id: String

    enum CodingKeys: CodingKey {
        case id
        case ID
        case identification
    }

    init(_ id: String) {
        self.id = id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        for key in iterateEnum(CodingKeys.self) {
            do {
                id = try container.decode(String.self, forKey: key)
                return
            } catch {
                continue
            }
        }
        throw CocoaError(.coderInvalidValue)
    }

    static func ==(lhs: MultiKeys, rhs: MultiKeys) -> Bool {
        return lhs.id == rhs.id
    }
}

// https://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}
