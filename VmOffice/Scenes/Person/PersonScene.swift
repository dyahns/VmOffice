import Foundation

enum PersonScene: AppScene {
    typealias Controller = PersonSceneViewController
    typealias Interactor = PersonSceneInteractor
    typealias Presenter = PersonScenePresenter
    typealias Router = PersonSceneRouter

    static let viewResource = StoryboardResource(storyboard: "PersonScene", identifier: nil)
    static let service: PersonServiceProtocol = PersonService(api: API())

    typealias Model = Person
//    struct Model {
//    }

    typealias Request = Person
//    struct Request {
//        let id: String
//    }

    typealias ViewModel = Model
//    struct ViewModel {
//    }
}
