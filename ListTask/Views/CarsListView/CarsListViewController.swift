// CarsViewController.swift
// ListTask , 
// Created by Doston Rustamov 22/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import UIKit

final class CarsListViewController: UIViewController {
    // MARK: - Properties
    var viewModel: CarsListViewModel?
    
    private var tableView: UITableView!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        fetchData()
    }
    
    
    // MARK: - Setup Methods
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    private func setupViewModel() {
        viewModel?.delegate = self
    }

    // MARK: - Data Methods
    private func fetchData() {
        viewModel?.fetchData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let car = viewModel?.car(at: indexPath.row) else { return cell }
        cell.textLabel?.text = "\(car.brand) \(car.model)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectCar(at: indexPath.row)
    }
}

extension CarsListViewController: CarsListViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func showOfflineMode() {
        tableView.reloadData()
    }
}

