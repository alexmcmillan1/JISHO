//
//  SceneDelegate.swift
//  JISHO
//
//  Created by Alex on 02/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.windowScene = windowScene
        window?.rootViewController = rootTabBarController()
        window?.makeKeyAndVisible()
    }
    
    private func rootTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([searchNavigationController(), favouritesNavigationController()], animated: false)
        return tabBarController
    }
    
    private func searchNavigationController() -> UINavigationController {
        let searchInteractor = SearchInteractor()
        let searchViewController = SearchViewController(output: searchInteractor)
        searchInteractor.viewInput = searchViewController
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        return navigationController
    }
    
    private func favouritesNavigationController() -> UINavigationController {
        let favouritesInteractor = FavouritesListInteractor(realmInteractor: RealmInteractor(), presenter: FavouritesListPresenter())
        let favouritesViewController = FavouritesListViewController(output: favouritesInteractor)
        favouritesInteractor.viewInput = favouritesViewController
        let navigationController = UINavigationController(rootViewController: favouritesViewController)
        navigationController.tabBarItem.title = "Favourites"
        navigationController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        return navigationController
    }
}
