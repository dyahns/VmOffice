import Foundation
@testable import VmOffice

struct MockPresenter: PresentationProtocol {
    typealias Scene = MockScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
}
