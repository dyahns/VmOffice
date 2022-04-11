import Foundation

protocol PersonServiceProtocol {
    func fetch(id: String, completion: @escaping (Result<Person, Error>) -> Void)
    func fetch(url: URL, completion: @escaping (Result<URL, Error>) -> Void)
}

class PersonService: PersonServiceProtocol {
    private let api: APIProtocol
    var prevRequest: Resumable?
    
    init(api: APIProtocol) {
        self.api = api
    }
    
    func fetch(id: String, completion: @escaping (Result<Person, Error>) -> Void) {
        let resource = Endpoint<Person>(path: "people/\(id)")
        prevRequest = api.load(resource, completion: completion)
    }
    
    func fetch(url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        let resource = Endpoint<Data>(path: "", baseUrl: url)
        prevRequest = api.download(resource, fileName: "avatar_\(url.hashValue)", completion: completion)
    }
}
