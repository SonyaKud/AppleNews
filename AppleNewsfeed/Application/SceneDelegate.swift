//
//  SceneDelegate.swift
//  AppleNewsfeed
//
//  Created by Софья Кудрявцева on 09.03.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         guard let scene = (scene as? UIWindowScene) else { return }
         window = UIWindow(windowScene: scene)
         let controller = NewsfeedViewController()
         let navigationController = UINavigationController(rootViewController: controller)
         window?.rootViewController = navigationController
         window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

