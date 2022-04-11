import Foundation

protocol PersonSceneViewProtocol: ViewProtocol {
    func display(with viewModel: PersonScene.ViewModel)
    func display(avatar: Data)

}

protocol PersonSceneInteractionProtocol: InteractionProtocol {
    func fetch()
}
 
protocol PersonScenePresentationProtocol: PresentationProtocol {
    func present(data: Result<PersonScene.Model, Error>)
    func present(avatar: Result<URL, Error>)
}

protocol PersonSceneRoutingProtocol: RoutingProtocol {
    func segueToNextScene()
}
