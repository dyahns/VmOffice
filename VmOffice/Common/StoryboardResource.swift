import UIKit

struct StoryboardResource {
    let storyboard: String
    let identifier: String?
}

extension StoryboardResource {
    func instantiate() -> UIViewController! {
        let storyboard = UIStoryboard.init(name: self.storyboard, bundle: nil)
        if #available(iOS 13.0, *), let identifier = self.identifier {
            return storyboard.instantiateViewController(identifier: identifier)
        } else {
            return storyboard.instantiateInitialViewController()
        }
    }
}
