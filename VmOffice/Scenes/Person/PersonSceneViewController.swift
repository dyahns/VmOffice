import UIKit

class PersonSceneViewController: UIViewController {
    var interactor: Scene.Interactor!
    var router: Scene.Router!

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var color: UILabel!
    
    private var viewModel: Scene.ViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            
            title = vm.name
            name.text = vm.name
            jobTitle.text = vm.jobtitle
            email.text = vm.email
            color.text = vm.favouriteColor
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetch()
    }
}

// MARK: - View Protocol

extension PersonSceneViewController: PersonSceneViewProtocol {
    typealias Scene = PersonScene
    
    func display(with viewModel: PersonScene.ViewModel) {
        self.viewModel = viewModel
    }

    func display(avatar: Data) {
        guard let image = UIImage(data: avatar) else {
            return
        }
        
        self.avatar.image = image
    }
}
