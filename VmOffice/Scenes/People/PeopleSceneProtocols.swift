import Foundation

protocol PeopleSceneViewProtocol: ViewProtocol {
    func display(with viewModel: PeopleScene.ViewModel)
}

protocol PeopleSceneInteractionProtocol: InteractionProtocol {
    func fetch()
}
 
protocol PeopleScenePresentationProtocol: PresentationProtocol {
    func present(data: Result<PeopleScene.Model, Error>)
}

protocol PeopleSceneRoutingProtocol: RoutingProtocol {
    func present(_ person: Person)
}
