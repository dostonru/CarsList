// SceneDelegate.swift
// ListTask , 
// Created by Doston Rustamov 22/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        setupMainWindow(in: windowScene)
    }

    private func setupMainWindow(in windowScene: UIWindowScene) {
        let navigationController = UINavigationController()
        let networkService = NetworkService()
        let databaseService = DatabaseService()
        
        let window = UIWindow(windowScene: windowScene)
        configureWindow(window, with: navigationController)
        
        coordinator = CarListCoordinator(navigationController: navigationController,
                                         networkService: networkService,
                                         databaseService: databaseService)
        coordinator.start(animated: false)
    }

    private func configureWindow(_ window: UIWindow, with rootViewController: UIViewController) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

