import Foundation

enum PeopleScene: AppScene {
    typealias Controller = PeopleSceneViewController
    typealias Interactor = PeopleSceneInteractor
    typealias Presenter = PeopleScenePresenter
    typealias Router = PeopleSceneRouter

    static let viewResource = StoryboardResource(storyboard: "PeopleScene", identifier: nil)
    static let service: PeopleServiceProtocol = PeopleService(api: API())

    typealias Model = People
//    struct Model {
//    }

    struct Request {
    }

    typealias ViewModel = Model
//    struct ViewModel {
//    }
}
