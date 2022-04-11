import Foundation

struct RoomsSceneRouter: RoomsSceneRoutingProtocol {
    typealias Scene = RoomsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func segueToBookingScene() {
        print("Booking is not implemented yet.")
//        let nextScene = NextScene.assemble(request: NextScene.Request())
//        controller?.show(nextScene, sender: nil)
    }
}
