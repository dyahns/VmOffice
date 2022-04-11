import XCTest
@testable import VmOffice

class APITests: XCTestCase {
    let url = URL(string: "http://cybg.com")!
    
    func testLoadSendsAPIRequest() {
        let urlSession = MockURLSession()
        let api = API(baseURL: url, urlSession: urlSession)
        let path = "/path/to/resource"
        let endpoint = Endpoint<MockModel>(path: path)

        api.load(endpoint) { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertEqual(urlSession.lastRequest?.httpMethod, "GET")
        XCTAssertEqual(urlSession.lastRequest?.url?.path, path)
    }

    func testDownloadSendsAPIRequest() {
        let urlSession = MockURLSession()
        let api = API(baseURL: url, urlSession: urlSession)
        let extUrl = URL(string: "http://external.url.com/path/filename.ext")!
        let endpoint = Endpoint<MockModel>(path: "", baseUrl: extUrl)

        api.download(endpoint, fileName: "cachedFilename.ext") { result in
        }
        
        XCTAssertEqual(urlSession.lastRequest?.httpMethod, "GET")
        XCTAssertEqual(urlSession.lastRequest?.url?.absoluteURL, extUrl)
    }

    func test_load_whenNoResponse_returnsNoResponseError() {
        let mockURLSession = MockURLSession()
        let api = API(baseURL: url, urlSession: mockURLSession)
        
        let callbackExpectation = expectation(description: "updated")
        api.load(Endpoint<MockModel>(path: "")) { result in
            callbackExpectation.fulfill()
            guard case .failure(let error) = result, let httpError = error as? HTTPError else {
                XCTFail("Should be error")
                return
            }
            guard case HTTPError.noResponse = httpError else {
                XCTFail("Should be .noResponse got \(httpError)")
                return
            }
        }
        mockURLSession.lastDataCompletionHandler?(nil, nil, nil)
        wait(for: [callbackExpectation], timeout: 0.1)
    }
    
    func test_load_whenError_returnsTheError() {
        let mockURLSession = MockURLSession()
        let api = API(baseURL: url, urlSession: mockURLSession)
        
        let callbackExpectation = expectation(description: "updated")
        api.load(Endpoint<MockModel>(path: "")) { result in
            callbackExpectation.fulfill()
            guard case .failure(let error) = result, let httpError = error as? HTTPError else {
                XCTFail("Should be error")
                return
            }
            guard case HTTPError.requestError(let theErrorToReturn) = httpError else {
                XCTFail("Should be .requestError got \(httpError)")
                return
            }
            guard let _ = theErrorToReturn as? MockError else {
                XCTFail("Wrong error returned")
                return
            }
        }
        mockURLSession.lastDataCompletionHandler?(nil, URLResponse(), MockError.test)
        wait(for: [callbackExpectation], timeout: 0.1)
    }
    
    func test_load_whenNotHTTPURLResponse_returnsInvalidResponse() {
        let mockURLSession = MockURLSession()
        let api = API(baseURL: url, urlSession: mockURLSession)
        
        let callbackExpectation = expectation(description: "updated")
        api.load(Endpoint<MockModel>(path: "")) { result in
            callbackExpectation.fulfill()
            guard case .failure(let error) = result, let httpError = error as? HTTPError else {
                XCTFail("Should be error")
                return
            }
            guard case HTTPError.invalidResponse = httpError else {
                XCTFail("Should be .invalidResponse got \(httpError)")
                return
            }
        }
        mockURLSession.lastDataCompletionHandler?(nil, URLResponse(), nil)
        wait(for: [callbackExpectation], timeout: 0.1)
    }
    
    func test_load_whenStatusCode500_returnsUnsuccessful() {
        let mockURLSession = MockURLSession()
        let api = API(baseURL: url, urlSession: mockURLSession)
        
        let callbackExpectation = expectation(description: "updated")
        api.load(Endpoint<MockModel>(path: "")) { result in
            callbackExpectation.fulfill()
            guard case .failure(let error) = result, let httpError = error as? HTTPError else {
                XCTFail("Should be error")
                return
            }
            guard case HTTPError.unsuccessful(let statusCode, _, _) = httpError else {
                XCTFail("Should be .unsuccessful got \(httpError)")
                return
            }
            XCTAssertEqual(statusCode, 500)
        }
        mockURLSession.lastDataCompletionHandler?(nil, HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: [:]), nil)
        wait(for: [callbackExpectation], timeout: 0.1)
    }
    
    func test_load_whenSuccessfulRequest_returnsDecodedModel() {
        let mockURLSession = MockURLSession()
        let api = API(baseURL: url, urlSession: mockURLSession)
        
        let callbackExpectation = expectation(description: "updated")
        api.load(Endpoint<MockModel>(path: "")) { result in
            callbackExpectation.fulfill()
            guard let model = try? result.get() else {
                XCTFail("Expected success got error")
                return
            }
            XCTAssertEqual(MockModel.model, model)
        }
        mockURLSession.lastDataCompletionHandler?(MockModel.data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [:]), nil)
        wait(for: [callbackExpectation], timeout: 0.1)
    }
}

