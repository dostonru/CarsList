// Car.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation

struct Car: Codable {
    let id: Int
    let createdAt: Date
    let brand: String
    let model: String
    let description: String
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, brand, model, description
        case images
    }
    
}
