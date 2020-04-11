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
        
        let searchInteractor = SearchInteractor()
        let searchViewController = SearchViewController(output: searchInteractor)
        
        searchInteractor.viewInput = searchViewController
        
        let navigationController = UINavigationController(rootViewController: searchViewController)
        
        let favouritesInteractor = FavouritesListInteractor(realmInteractor: RealmInteractor(), presenter: FavouritesListPresenter())
        let favourites = FavouritesListViewController(output: favouritesInteractor)
        favouritesInteractor.viewInput = favourites
        
        navigationController.tabBarItem.title = "Search"
        navigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        favourites.tabBarItem.title = "Favourites"
        favourites.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([navigationController, favourites], animated: false)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
