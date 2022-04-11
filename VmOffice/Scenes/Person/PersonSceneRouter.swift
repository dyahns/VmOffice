import Foundation

struct PersonSceneRouter: PersonSceneRoutingProtocol {
    typealias Scene = PersonScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func segueToNextScene() {
        print("Segue to next scene...")
//        let nextScene = NextScene.assemble(request: NextScene.Request())
//        controller?.show(nextScene, sender: nil)
    }
}
