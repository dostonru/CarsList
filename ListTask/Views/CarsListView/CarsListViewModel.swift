// MainViewModel.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation

protocol CarsListViewModelDelegate: AnyObject {
    func reloadTableView()
    func showOfflineMode()
}

final class CarsListViewModel: Coordinating {
    weak var delegate: CarsListViewModelDelegate?
    weak var coordinatorDelegate: CarsListViewModelCoordinatorDelegate?
    weak var coordinator: Coordinator?

    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol

    var cars: [Car] = []

    init(networkService: NetworkServiceProtocol, databaseService: DatabaseServiceProtocol) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func fetchData() {
        guard NetworkReachability.isConnected() else {
            cars = databaseService.getCars()
            delegate?.reloadTableView()
            delegate?.showOfflineMode()
            return
        }
        
        networkService.getCars { [weak self] result in
            switch result {
            case .success(let cars):
                self?.cars = cars
                self?.databaseService.saveCars(cars)
                self?.delegate?.reloadTableView()
            case .failure(let error):
                print("Error fetching cars: \(error)")
            }
        }
    }

    func didSelectCar(at index: Int) {
        guard index < cars.count else { return }
        let selectedCar = cars[index]
        coordinatorDelegate?.showCarDetails(selectedCar)
    }
    
    func car(at index: Int) -> Car {
        return cars[index]
    }
}
