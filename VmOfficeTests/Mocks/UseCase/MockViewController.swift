import Foundation
@testable import VmOffice

class MockViewController: ViewProtocol {
    typealias Scene = MockScene
    var interactor: Scene.Interactor!
    var router: Scene.Router!
}
