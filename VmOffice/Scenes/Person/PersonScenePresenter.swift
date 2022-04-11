import Foundation

struct PersonScenePresenter: PersonScenePresentationProtocol {
    typealias Scene = PersonScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func present(data: Result<PersonScene.Model, Error>) {
        relayResult(data) { (success) in
//            let viewModel = PersonScene.ViewModel()
            self.controller?.display(with: success)
        }
    }
    
    func present(avatar: Result<URL, Error>) {
        relayResult(avatar) { (success) in
            // keep read on background thread
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: success)
                let result: Result<Data, Error> = data != nil ? .success(data!) : .failure(PersistenceError.readFailed)
                
                relayResult(result) { data in
                    self.controller?.display(avatar: data
                    )
                }
            }
        }
    }
}
