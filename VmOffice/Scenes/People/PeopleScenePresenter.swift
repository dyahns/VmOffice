import Foundation

struct PeopleScenePresenter: PeopleScenePresentationProtocol {
    typealias Scene = PeopleScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func present(data: Result<PeopleScene.Model, Error>) {
        relayResult(data) { (success) in
//            let viewModel = PeopleScene.ViewModel()
            self.controller?.display(with: success)
        }
    }
}
