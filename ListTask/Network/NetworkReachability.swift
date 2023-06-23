// NetworkReachability.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation
import SystemConfiguration

final class NetworkReachability {
    static func isConnected() -> Bool {
        guard let url = URL(string: "https://www.google.com") else {
            return false
        }

        let request = URLRequest(url: url)
        let semaphore = DispatchSemaphore(value: 0)

        var isConnected = false

        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                isConnected = true
            }
            semaphore.signal()
        }.resume()

        semaphore.wait()

        return isConnected
    }
}

