import Foundation
@testable import VmOffice

struct MockService {}

struct MockPeopleService: PeopleServiceProtocol {
    func fetch(completion: @escaping (Result<People, Error>) -> Void) {}
}
