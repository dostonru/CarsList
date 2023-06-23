// ImageCollectionViewCell.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation
import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setImage(with imageURL: String) {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url),
                  let image = UIImage(data: imageData) else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
