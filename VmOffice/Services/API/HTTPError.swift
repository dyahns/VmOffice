import Foundation

enum HTTPError: Error {
    case noResponse
    case emptyResponse
    case requestError(Error)
    case invalidResponse(URLResponse)
    case errorResponse(ErrorResponse)
    case unsuccessful(statusCode: Int, urlResponse: HTTPURLResponse, error: Error?)
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResponse:
            return "No Response"
        case .emptyResponse:
            return "No data returned from the server"
        case .requestError(let error):
            return "Request Error: \(error)"
        case .invalidResponse(let response):
            return "Invalid response. Expected HTTPURLResponse got \(type(of: response))"
        case .errorResponse(let response):
            return "\(response)"
        case .unsuccessful(let statusCode, _, _):
            switch statusCode {
            case 401:
                return "Authentication failure"
            case 404:
                return "Requested resource not found"
            case 500:
                return "Server error"
            default:
                return "Unsuccessful. Status code: \(statusCode)"
            }
        }
    }
}

struct ErrorResponse: Decodable {
    let title: String?
    let detail: String?
}

extension ErrorResponse: CustomStringConvertible {
    var description: String {
        [title, detail].compactMap({$0}).joined(separator: "\n")
    }
}

extension DecodingError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dataCorrupted(let context):
            return "Data corrupted at \(context.codingPath)"
        case .keyNotFound(let key, let context):
            return "Key \(key) not found at \(context.codingPath)"
        case .typeMismatch(_, let context):
            return "Type mismatch at \(context.codingPath)"
        case .valueNotFound(_, let context):
            return "Value missing at \(context.codingPath)"
        @unknown default:
            return "Decoding error"
        }
    }
}
