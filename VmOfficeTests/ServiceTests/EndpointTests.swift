import XCTest
@testable import VmOffice

class EndpointTests: XCTestCase {
    func testCanParseDecodableModels() {
        let endpoint = Endpoint<MockModel>(path: "", query: "")
        let result = endpoint.parse(MockModel.data)
        guard let model = try? result.get() else {
            XCTFail("Bad JSON")
            return
        }
        
        XCTAssertEqual(model, MockModel.model)
    }
}

