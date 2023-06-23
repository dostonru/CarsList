// Coordinator.swift
// ListTask , 
// Created by Doston Rustamov 22/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start(animated: Bool)
}


protocol Coordinating: AnyObject {
    var coordinator: Coordinator? { get set }
}


