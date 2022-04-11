import Foundation

protocol RoomsServiceProtocol {
    func fetch(completion: @escaping (Result<Rooms, Error>) -> Void)
}

class RoomsService: RoomsServiceProtocol {
    private let api: APIProtocol
    var prevRequest: Resumable?
    
    init(api: APIProtocol) {
        self.api = api
    }
    
    func fetch(completion: @escaping (Result<Rooms, Error>) -> Void) {
        let resource = Endpoint<Rooms>(path: "rooms")
        prevRequest = api.load(resource, completion: completion)
    }
}
