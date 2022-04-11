import Foundation

// MARK: - Controller
protocol ViewProtocol: AnyObject {
    associatedtype Scene: AppScene
    var interactor: Scene.Interactor! { get set }
    var router: Scene.Router! { get set }
    func displayError(_ error: Error)
}

extension ViewProtocol {
    func displayError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

// MARK: - Interactor
protocol InteractionProtocol {
    associatedtype Scene: AppScene
    var presenter: Scene.Presenter { get }
    var service: Scene.Service { get }
    init(request: Scene.Request, service: Scene.Service, presenter: Scene.Presenter)
}

// MARK: - Presenter
protocol PresentationProtocol {
    associatedtype Scene: AppScene
    var controller: Scene.Controller? { get }
    init(controller: Scene.Controller)
}

extension PresentationProtocol {
    func onMain(_ action: @escaping () -> ()) {
        DispatchQueue.main.async {
            action()
        }
    }
    
    func relayResult<T>(_ result: Result<T, Error>, onSuccess: @escaping (T) -> Void) {
        switch result {
        case .success(let success):
            onMain {
                onSuccess(success)
            }

        case .failure(let error):
            onMain {
                self.controller?.displayError(error)
            }
        }
    }
}

// MARK: - Router
protocol RoutingProtocol {
    associatedtype Scene: AppScene
    var controller: Scene.Controller? { get }
    init(controller: Scene.Controller)
}
