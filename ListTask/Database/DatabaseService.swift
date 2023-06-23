// DatabaseService.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation
import CoreData

protocol DatabaseServiceProtocol {
    func saveCars(_ cars: [Car])
    func getCars() -> [Car]
}

final class DatabaseService: DatabaseServiceProtocol {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CarsDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveCars(_ cars: [Car]) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            self.clearDatabase()
            
            do {
                let carEntities = cars.map { car in
                    let carEntity = CarEntity(context: self.context)
                    carEntity.populate(from: car)
                    return carEntity
                }
                
                try self.context.save()
            } catch {
                print("Failed to save cars: \(error)")
            }
        }
    }
    
    func getCars() -> [Car] {
        let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        
        do {
            let carEntities = try context.fetch(fetchRequest)
            
            let cars = carEntities.map { carEntity -> Car in
                return carEntity.convertToCar()
            }
            
            return cars
        } catch {
            print("Failed to fetch cars: \(error)")
            return []
        }
    }
    
    
    private func clearDatabase() {
        let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Failed to clear database: \(error)")
        }
    }
}


