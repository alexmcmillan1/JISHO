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
        
        window?.rootViewController = UINavigationController(rootViewController: searchViewController)
        window?.makeKeyAndVisible()
    }
}
