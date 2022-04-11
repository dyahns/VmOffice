import Foundation

enum RoomsScene: AppScene {
    typealias Controller = RoomsSceneViewController
    typealias Interactor = RoomsSceneInteractor
    typealias Presenter = RoomsScenePresenter
    typealias Router = RoomsSceneRouter

    static let viewResource = StoryboardResource(storyboard: "RoomsScene", identifier: nil)
    static let service: RoomsServiceProtocol = RoomsService(api: API())

    typealias Model = Rooms
//    struct Model {
//    }

    struct Request {
    }

    typealias ViewModel = Model
//    struct ViewModel {
//    }
}
