// CarEntity+Convert.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation

extension CarEntity {
    
    func populate(from car: Car) {
        id = Int32(car.id)
        createdAt = car.createdAt
        brand = car.brand
        model = car.model
        descriptionCar = car.description
        images = car.images as NSObject
    }
    
    func convertToCar() -> Car {
        return Car(id: Int(id),
                   createdAt: createdAt ?? Date(),
                   brand: brand ?? "",
                   model: model ?? "",
                   description: descriptionCar ?? "",
                   images: (images ?? [] as NSObject) as! [String])
    }
}
