import UIKit

class RoomsSceneViewController: UITableViewController {
    var interactor: Scene.Interactor!
    var router: Scene.Router!

    private var viewModel: Scene.ViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetch()
    }

    @IBAction func segueActioned(_ sender: Any) {
        router.segueToBookingScene()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let room = viewModel?[indexPath.row] else {
            return cell
        }

        // Configure the cell...
        cell.textLabel?.text = "\(room.id)"
        cell.detailTextLabel?.text = "Max occupancy: \(room.maxOccupancy)"
        cell.accessoryType = room.isOccupied ? .none : .checkmark
        
        
        return cell
    }
}

// MARK: - Table view delegate

extension RoomsSceneViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.segueToBookingScene()
    }
}

// MARK: - View Protocol

extension RoomsSceneViewController: RoomsSceneViewProtocol {
    typealias Scene = RoomsScene
    
    func display(with viewModel: RoomsScene.ViewModel) {
        self.viewModel = viewModel
    }
}
