import Foundation

class PeopleSceneInteractor: PeopleSceneInteractionProtocol {
    typealias Scene = PeopleScene
    let presenter: Scene.Presenter
    let service: Scene.Service
    let request: Scene.Request

    required init(request: Scene.Request, service: Scene.Service, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
        self.request = request
    }

    func fetch() {
        presenter.present(data: .success(PeopleScene.Model()))

        service.fetch { (result) in
            self.presenter.present(data: result)
        }
    }
}
