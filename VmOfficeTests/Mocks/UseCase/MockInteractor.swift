import Foundation
@testable import VmOffice

struct MockInteractor: InteractionProtocol {
    typealias Scene = MockScene
    var presenter: Scene.Presenter
    var service: MockService
    
    init(request: Scene.Request, service: MockService, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
    }
}
