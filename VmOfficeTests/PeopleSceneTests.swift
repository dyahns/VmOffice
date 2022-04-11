import XCTest
@testable import VmOffice

class PeopleSceneTests: XCTestCase, SceneTests {
    typealias Scene = PeopleScene
    var controller: Scene.Controller!
    
    override func setUp() {
        controller = PeopleScene.assemble(request: PeopleScene.Request(), viewControler: PeopleSceneViewController(), service: MockPeopleService())
    }
    
    func testCompositionRoot() {
        testSceneReferences()
    }
    
    func testPresenterReferencesControllerWeakly() {
        testPresenterReferencesControllerWeakly(newController: PeopleSceneViewController())
    }
    
    func testRouterReferencesControllerWeakly() {
        testRouterReferencesControllerWeakly(newController: PeopleSceneViewController())
    }
}
