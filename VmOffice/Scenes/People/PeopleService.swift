import Foundation

protocol PeopleServiceProtocol {
    func fetch(completion: @escaping (Result<People, Error>) -> Void)
}

class PeopleService: PeopleServiceProtocol {
    private let api: APIProtocol
    var prevRequest: Resumable?
    
    init(api: APIProtocol) {
        self.api = api
    }
    
    func fetch(completion: @escaping (Result<People, Error>) -> Void) {
        let resource = Endpoint<People>(path: "people")
        prevRequest = api.load(resource, completion: completion)
    }
}
