import Foundation

enum PersistenceError: Error {
    case notPersisted(String)
    case readFailed
    case deseralizationFailed
}

extension PersistenceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notPersisted(let key):
            return "Value with key \(key) is not in the cache"
        case .readFailed:
            return "Failed to read data from file"
        case .deseralizationFailed:
            return "Failed to deserialize data!"
        }
    }
}
