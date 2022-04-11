import Foundation

class PersonSceneInteractor: PersonSceneInteractionProtocol {
    typealias Scene = PersonScene
    let presenter: Scene.Presenter
    let service: Scene.Service
    let request: Scene.Request

    required init(request: Scene.Request, service: Scene.Service, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
        self.request = request
    }

    func fetch() {
        // present from request model
        presenter.present(data: .success(request))

        // then update from API
        let id = request.id
        service.fetch(id: id) { (result) in
            self.presenter.present(data: result)
            
            guard let person = try? result.get(), let url = URL(string: person.avatar) else {
                return
            }
            
            self.service.fetch(url: url) { localUrl in
                self.presenter.present(avatar: localUrl)
            }
        }
    }
}
