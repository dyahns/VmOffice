import Foundation

protocol APIProtocol {
    func load<Model>(_ endpoint: Endpoint<Model>, completion: @escaping (Result<Model, Error>) -> Void) -> Resumable?
    func download<Model>(_ endpoint: Endpoint<Model>, to directory: FileManager.SearchPathDirectory, fileName: String, overwrite: Bool, completion: @escaping (Result<URL, Error>) -> Void) -> Resumable?
    func download<Model>(_ endpoint: Endpoint<Model>, fileName: String, completion: @escaping (Result<URL, Error>) -> Void) -> Resumable?
}

extension APIProtocol {
    @discardableResult
    func download<Model>(_ endpoint: Endpoint<Model>, fileName: String, completion: @escaping (Result<URL, Error>) -> Void) -> Resumable? {
        download(endpoint, to: .cachesDirectory, fileName: fileName, overwrite: false, completion: completion)
    }
}

class API: APIProtocol {
    private let urlSession: URLSessionProtocol
    private let baseURL: URL

    static var vmBaseURL: URL = {
        guard let urlString = Bundle.main.ApiBaseUrl, let url = URL(string: urlString) else {
            preconditionFailure("API base URL is missing!")
        }
        
        print("Base URL: \(url.absoluteString)")
        return url
    }()
    
    init(baseURL: URL = vmBaseURL, urlSession: URLSessionProtocol = URLSession.shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    @discardableResult
    func load<Model>(_ endpoint: Endpoint<Model>, completion: @escaping (Result<Model, Error>) -> Void) -> Resumable? {
        guard let urlRequest = URLRequest(baseURL: baseURL, endpoint: endpoint) else { return nil }

        print("Sending request to \(urlRequest.httpMethod ?? "") \(urlRequest)...")
        let task = urlSession.resumableDataTask(with: urlRequest) {
            self.responseHandler(data: $0, urlResponse: $1, error: $2, endpoint: endpoint, completion: completion) {
                endpoint.parse($0)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func download<Model>(_ endpoint: Endpoint<Model>, to directory: FileManager.SearchPathDirectory, fileName: String, overwrite: Bool, completion: @escaping (Result<URL, Error>) -> Void) -> Resumable? {
        guard let directory = try? FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
        let destination = directory.appendingPathComponent(fileName)
        
        if !overwrite, FileManager.default.fileExists(atPath: destination.path) {
            print("Serving file \(fileName) from cache...")
            completion(.success(destination))
            return nil
        }
        
        guard let urlRequest = URLRequest(baseURL: baseURL, endpoint: endpoint) else { return nil }
        print("Sending request to \(urlRequest.httpMethod ?? "") \(urlRequest)...")

        let task = urlSession.resumableDataTask(with: urlRequest) { data, response, error in
            self.responseHandler(data: data, urlResponse: response, error: error, endpoint: endpoint, completion: completion) { data in
                do {
                    if FileManager.default.fileExists(atPath: destination.path) {
                        try FileManager.default.removeItem(at: destination)
                    }
                    
                    try data.write(to: destination)
                } catch {
                    return .failure(PersistenceError.notPersisted(error.localizedDescription))
                }
                
                return .success(destination)
            }
        }

        task.resume()
        return task
    }


    private func responseHandler<Model, T>(data: Data?, urlResponse: URLResponse?, error: Error?, endpoint: Endpoint<Model>, completion: @escaping (Result<T, Error>) -> Void, parser: (Data) -> Result<T, Error>) {

        if let error = error {
            // ignore completion if request has been cancelled in the code
            if (error as NSError).code != NSURLErrorCancelled {
                completion(.failure(HTTPError.requestError(error)))
            }
            return
        }
        guard let urlResponse = urlResponse else {
            print("HTTPError.noResponse \(endpoint)")
            completion(.failure(HTTPError.noResponse))
            return
        }
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            completion(.failure(HTTPError.invalidResponse(urlResponse)))
            return
        }
        guard (200..<300).contains(httpURLResponse.statusCode) else {
            // try to parse standard descriptive response first
            if let data = data, !data.isEmpty, let standardResponse: ErrorResponse = try? data.parse().get() {
                completion(.failure(HTTPError.errorResponse(standardResponse)))
                return
            }
            
            var props = ["URL": "\(endpoint)", "Status Code": "\(httpURLResponse.statusCode)", "Error": error?.localizedDescription ?? ""]
            httpURLResponse.allHeaderFields.forEach {
                let (key, value) = $0
                props["Header \(key)"] = "\(value)"
            }

            // otherwise return low level HTTP response details
            completion(.failure(HTTPError.unsuccessful(statusCode: httpURLResponse.statusCode, urlResponse: httpURLResponse, error: error)))
            return
        }
        
        guard let data = data else {
            completion(.failure(HTTPError.emptyResponse))
            return
        }
        
        completion(parser(data))
    }
}
