import Foundation
@testable import VmOffice

class MockAPI: APIProtocol {
    var apiShouldSucceed = true
    var requestsSent = 0

    func load<Model>(_ endpoint: Endpoint<Model>, completion: @escaping (Result<Model, Error>) -> Void) -> Resumable? {
        requestsSent += 1
        
        if apiShouldSucceed {
            completion(Result.success(MockModel(value: 1) as! Model))
        } else {
            completion(.failure(MockError.test))
        }
        
        return nil
    }
    
    func download<Model>(_ endpoint: Endpoint<Model>, to directory: FileManager.SearchPathDirectory, fileName: String, overwrite: Bool, completion: @escaping (Result<URL, Error>) -> Void) -> Resumable? {
        requestsSent += 1
        
        if apiShouldSucceed {
            completion(Result.success(URL(string: "")!))
        } else {
            completion(.failure(MockError.test))
        }
        
        return nil
    }
    
}
