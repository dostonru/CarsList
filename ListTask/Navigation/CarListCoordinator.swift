// MainCoordinator.swift
// ListTask , 
// Created by Doston Rustamov 22/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation
import UIKit

protocol CarsListViewModelCoordinatorDelegate: AnyObject {
    func showCarDetails(_ car: Car)
}


final class CarListCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol
    
    init(navigationController: UINavigationController,
         networkService: NetworkServiceProtocol,
         databaseService: DatabaseServiceProtocol
    ) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    
    func start(animated: Bool) {
        let viewController = createInitialViewController()
        navigationController?.setViewControllers(
            [viewController],
            animated: animated
        )
    }
    
    
    private func createInitialViewController() -> UIViewController {
        let viewModel = CarsListViewModel(
            networkService: networkService,
            databaseService: databaseService
        )
        let viewController: CarsListViewController = CarsListViewController()
        
        viewModel.coordinatorDelegate = self
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        return viewController
    }
}

extension CarListCoordinator: CarsListViewModelCoordinatorDelegate {
    
    func showCarDetails(_ car: Car) {
        let coordinator = CarDetailsCoordinator(
            navigationController: navigationController!,
            car: car
        )
        coordinator.start(animated: true)
    }
}
