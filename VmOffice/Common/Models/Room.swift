import Foundation

struct Room: Codable {
    let id: String
    let createdAt: Date //"2022-01-24T20:52:50.765Z",
    let isOccupied: Bool
    let maxOccupancy: Int
}

typealias Rooms = [Room]
