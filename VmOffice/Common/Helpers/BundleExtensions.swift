import Foundation

extension Bundle {
    var ApiBaseUrl: String? {
        return object(forInfoDictionaryKey: "ApiBaseUrl") as? String
    }
}
