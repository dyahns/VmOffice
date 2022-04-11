import Foundation

struct Endpoint<Model> {
    let path: String
    let query: String?
    let body: Data?
    let method: String
    let token: String?
    let parse: (Data) -> Result<Model, Error>
    let baseUrl: URL?
}

extension Endpoint where Model: Decodable {
    init(path: String, query: String? = nil, method: String = "GET", token: String? = nil, baseUrl: URL? = nil) {
        self.path = path
        self.method = method
        self.query = query
        self.body = nil
        self.token = token
        self.baseUrl = baseUrl
        
        parse = { $0.parse() }
    }
}

extension Endpoint: CustomStringConvertible {
    var description: String {
        let q = query == nil ? "" : "?\(query!)"
        return "\(method) \(path)\(q)"
    }
}
