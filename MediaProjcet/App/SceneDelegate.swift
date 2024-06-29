//
//  SceneDelegate.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let searchMovieVC = UINavigationController(rootViewController: SearchMovieViewController())
        let trendingVC = UINavigationController(rootViewController: TrendingViewController()) 
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([searchMovieVC, trendingVC], animated: true)
        tabBarController.tabBar.tintColor = .white
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "popcorn.fill")
            items[0].image = UIImage(systemName: "popcorn")
            items[0].title = "search"
            
            items[1].image = UIImage(systemName: "chart.line.uptrend.xyaxis")
            items[1].title = "trending"
        }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

