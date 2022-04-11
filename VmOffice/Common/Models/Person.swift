import Foundation

struct Person: Codable {
    let id: String
    let createdAt: Date // "2022-01-24T17:02:23.729Z",
    let firstName: String
    let avatar: String
    let lastName: String
    let email: String
    let jobtitle: String
    let favouriteColor: String
}

typealias People = [Person]

extension Person {
    var name: String {
        "\(firstName) \(lastName)"
    }
}
