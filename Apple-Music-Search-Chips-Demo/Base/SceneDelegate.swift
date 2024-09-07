//
//  SceneDelegate.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 02/08/2024.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let rootViewController = ViewController()
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.tintColor = .systemPink
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        
        self.window = window
    }
}
