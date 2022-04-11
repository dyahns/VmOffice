import Foundation
 
extension URLRequest {
    init?<T>(baseURL: URL, endpoint: Endpoint<T>) {
        var urlComponents = URLComponents(url: endpoint.baseUrl ?? baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)
        urlComponents?.query = endpoint.query
        guard let url = urlComponents?.url else {
            assertionFailure("Invalid endpoint: \(endpoint)")
            return nil
        }

        self.init(url: url)
        httpMethod = endpoint.method
        httpBody = endpoint.body

        if let token = endpoint.token {
            addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
