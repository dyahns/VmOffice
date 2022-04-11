import Foundation

struct PeopleSceneRouter: PeopleSceneRoutingProtocol {
    typealias Scene = PeopleScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func present(_ person: Person) {
        let personScene = PersonScene.assemble(request: person)
        controller?.show(personScene, sender: nil)
    }
}
