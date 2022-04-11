import Foundation
import UIKit

extension UIWindow {
    func assembleNavStructure() -> UIWindow {
        if #available(iOS 13, *) {
            configureAppearance()
        }
        
        let peopleScene = PeopleScene.assemble(request: PeopleScene.Request())
        let navVC1 = UINavigationController(rootViewController: peopleScene)
        
        let roomsScene = RoomsScene.assemble(request: RoomsScene.Request())
        let navVC2 = UINavigationController(rootViewController: roomsScene)
        
        let tabVC = UITabBarController()
        tabVC.viewControllers = [navVC1, navVC2]
        
        rootViewController = tabVC
        makeKeyAndVisible()
        
        return self
    }
    
    @available(iOS 13, *)
    private func configureAppearance() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navAppearance.backgroundColor = UIColor(named: "BrandColor")
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UIBarButtonItem.appearance().tintColor = .white
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(named: "BrandColor")
        UITabBar.appearance().standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
        UITabBar.appearance().tintColor = .white
    }
}
