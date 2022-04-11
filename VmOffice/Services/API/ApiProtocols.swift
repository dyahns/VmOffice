import Foundation

protocol Resumable {
    func resume()
    func cancel()
}

extension URLSessionDataTask: Resumable {}
extension URLSessionDownloadTask: Resumable {}

protocol URLSessionProtocol {
    func resumableDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Resumable
    func resumableDownloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> Resumable
}

extension URLSession: URLSessionProtocol {
    func resumableDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Resumable {
        return dataTask(with: request, completionHandler: completionHandler)
    }

    func resumableDownloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> Resumable {
        return downloadTask(with: request, completionHandler: completionHandler)
    }
}
