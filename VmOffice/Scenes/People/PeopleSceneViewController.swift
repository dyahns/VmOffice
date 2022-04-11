import UIKit

class PeopleSceneViewController: UITableViewController {
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let person = viewModel?[indexPath.row] else {
            return cell
        }

        // Configure the cell...
        cell.textLabel?.text = "\(person.name)"
        
        return cell
    }
}

// MARK: - Table view delegate

extension PeopleSceneViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        guard let viewModel = viewModel, viewModel.indices.contains(row) else {
            return
        }
        
        let person = viewModel[row]
        router.present(person)
    }
}

// MARK: - View Protocol

extension PeopleSceneViewController: PeopleSceneViewProtocol {
    typealias Scene = PeopleScene
    
    func display(with viewModel: PeopleScene.ViewModel) {
        self.viewModel = viewModel
    }
}
