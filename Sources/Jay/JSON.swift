import Foundation

@dynamicMemberLookup
public enum JSON: Codable {

    case bool(Bool)
    case number(Double)
    case string(String)
    case null
    indirect case array([JSON])
    indirect case dictionary([String: JSON])

}

extension JSON {

    public var boolValue: Bool? {
        guard case .bool(let value) = self else {
            return nil
        }

        return value
    }

    public var doubleValue: Double? {
        guard case .number(let value) = self else {
            return nil
        }

        return value
    }

    public var stringValue: String? {
        guard case .string(let value) = self else {
            return nil
        }

        return value
    }

}

extension JSON {

    public subscript(dynamicMember member: String) -> JSON? {
        guard case .dictionary(let dictionary) = self else {
            return nil
        }

        return dictionary[member]
    }

    public subscript(index: Int) -> JSON? {
        guard case .array(let array) = self else {
            return nil
        }

        return array[index]
    }

}

extension JSON {

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let number = try? container.decode(Double.self) {
            self = .number(number)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if container.decodeNil() {
            self = .null
        } else if let array = try? container.decode([JSON].self) {
            self = .array(array)
        } else if let object = try? container.decode([String: JSON].self) {
            self = .dictionary(object)
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "")
            throw DecodingError.dataCorrupted(context)
        }

    }

}

extension JSON {

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()

        switch self {
        case .bool(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        case .array(let value):
            try container.encode(value)
        case .dictionary(let value):
            try container.encode(value)
        }

    }

}
