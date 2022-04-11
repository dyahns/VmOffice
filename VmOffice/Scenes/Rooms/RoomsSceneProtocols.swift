import Foundation

protocol RoomsSceneViewProtocol: ViewProtocol {
    func display(with viewModel: RoomsScene.ViewModel)
}

protocol RoomsSceneInteractionProtocol: InteractionProtocol {
    func fetch()
}
 
protocol RoomsScenePresentationProtocol: PresentationProtocol {
    func present(data: Result<RoomsScene.Model, Error>)
}

protocol RoomsSceneRoutingProtocol: RoutingProtocol {
    func segueToBookingScene()
}
