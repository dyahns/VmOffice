import Foundation

struct RoomsScenePresenter: RoomsScenePresentationProtocol {
    typealias Scene = RoomsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func present(data: Result<RoomsScene.Model, Error>) {
        relayResult(data) { (success) in
//            let viewModel = RoomsScene.ViewModel()
            self.controller?.display(with: success)
        }
    }
}
