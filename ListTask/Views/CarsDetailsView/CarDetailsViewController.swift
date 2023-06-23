// CarDetailsViewController.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import UIKit

final class CarDetailsViewController: UIViewController {
    
    var viewModel: CarDetailsViewModel?
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var collectionView: UICollectionView!
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayCarDetails()
        
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
        
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }

    private func setupCollectionView() {
        let collectionViewFlowLayout = createCollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        return collectionViewFlowLayout
    }
    
    // MARK: - Data Display
    
    private func displayCarDetails() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
        titleLabel.text = "\(viewModel?.car.brand ?? "") \(viewModel?.car.model ?? "")"
        descriptionLabel.text = "Created at: \(dateFormatter.string(from: viewModel?.car.createdAt ?? Date() ))\n\n\(viewModel?.car.description ?? "")"
    }
}

extension CarDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.car.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        if let imageURL = viewModel?.car.images[indexPath.item] {
            cell.setImage(with: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.height - 20
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
