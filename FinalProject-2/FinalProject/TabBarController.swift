//
//  TabBarController.swift
//  FinalProject
//
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewControllers = [
            barItem(tabBarTitle: "Home", tabBarImage: UIImage(systemName: "house.fill")!.withTintColor(UIColor.iconTab, renderingMode: .alwaysOriginal), viewController: HomeViewController()),
          
            barItem(tabBarTitle: "Add Product" , tabBarImage: UIImage(systemName: "plus.circle.fill")!.withTintColor(UIColor.iconTab, renderingMode: .alwaysOriginal), viewController: AddProductViewController()),
            barItem(tabBarTitle: "Chats", tabBarImage: UIImage(systemName: "message.fill")!.withTintColor(UIColor.iconTab, renderingMode: .alwaysOriginal), viewController: ChatsVC()),
            barItem(tabBarTitle: "Profile", tabBarImage: UIImage(systemName: "person.fill")!.withTintColor(UIColor.iconTab, renderingMode: .alwaysOriginal), viewController: ProfileViewController()),
        ]
        selectedIndex = 0
        tabBar.isTranslucent = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        tabBar.unselectedItemTintColor = .gray
    }
    
    //MARK: - BarTab 
    private func barItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = tabBarImage
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
}
