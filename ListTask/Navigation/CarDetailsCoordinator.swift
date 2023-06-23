// CarDetailsCoordinator.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation
import UIKit

final class CarDetailsCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    private let car: Car

    init(navigationController: UINavigationController, car: Car) {
        self.navigationController = navigationController
        self.car = car
    }

    func start(animated: Bool) {
        let viewController = CarDetailsViewController()
        let viewModel = CarDetailsViewModel(car: car)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
