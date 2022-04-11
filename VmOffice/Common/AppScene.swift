import UIKit

protocol AppScene {
    associatedtype Controller: ViewProtocol where Controller.Scene == Self
    associatedtype Interactor: InteractionProtocol where Interactor.Scene == Self
    associatedtype Presenter: PresentationProtocol where Presenter.Scene == Self
    associatedtype Router: RoutingProtocol where Router.Scene == Self
    associatedtype Request
    associatedtype Service

    static var viewResource: StoryboardResource { get }
    static var service: Service { get }
}

extension AppScene {
    static func assemble(request: Request, viewControler: Controller? = nil, service: Service? = nil) -> Controller {
        let controller = viewControler ?? instantiateFromResource()
        let presenter = Presenter.init(controller: controller)
        controller.interactor = Interactor.init(request: request, service: service ?? self.service, presenter: presenter)
        controller.router = Router.init(controller: controller)

        return controller
    }
    
    static private func instantiateFromResource() -> Controller {
        Self.viewResource.instantiate() as! Controller
    }
}
