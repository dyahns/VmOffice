import Foundation
@testable import VmOffice

struct ResumableStub: Resumable {
    func cancel() {}
    func resume() {}
}

class MockURLSession: URLSessionProtocol {
    private let urlSession = URLSession(configuration: .default)
    var lastRequest: URLRequest? = nil
    var lastDataCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil
    var lastDownloadCompletionHandler: ((URL?, URLResponse?, Error?) -> Void)? = nil

    func resumableDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Resumable {
        lastRequest = request
        lastDataCompletionHandler = completionHandler
        return ResumableStub()
    }

    func resumableDownloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> Resumable {
        lastRequest = request
        lastDownloadCompletionHandler = completionHandler
        return ResumableStub()
    }
}
