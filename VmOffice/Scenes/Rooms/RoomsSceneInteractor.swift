import Foundation

class RoomsSceneInteractor: RoomsSceneInteractionProtocol {
    typealias Scene = RoomsScene
    let presenter: Scene.Presenter
    let service: Scene.Service
    let request: Scene.Request

    required init(request: Scene.Request, service: Scene.Service, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
        self.request = request
    }

    func fetch() {
        service.fetch { (result) in
            self.presenter.present(data: result)
        }
    }
}
