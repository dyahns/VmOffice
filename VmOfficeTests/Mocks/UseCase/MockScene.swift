import Foundation
@testable import VmOffice

enum MockScene: AppScene {
    typealias Controller = MockViewController
    typealias Interactor = MockInteractor
    typealias Presenter = MockPresenter
    typealias Router = MockRouter

    static let viewResource = StoryboardResource(storyboard: "MockScene", identifier: nil)
    static let service = MockService()

    struct Request {}

    struct Data: Codable {}
}
