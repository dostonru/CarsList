// NetworkService.swift
// ListTask , 
// Created by Doston Rustamov 23/06/23.
// Copyright 2023 Doston Rustamov . All rights reserved.

import Foundation

protocol NetworkServiceProtocol {
    func getCars(completion: @escaping (Result<[Car], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func getCars(completion: @escaping (Result<[Car], Error>) -> Void) {
        guard let url = URL(string: "https://xenr-r2up-tben.n7c.xano.io/api:6mbbF8N6/car") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.isSuccessfulResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let carResponse = try self?.decodeCarResponse(from: data)
                completion(.success(carResponse ?? []))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    private func decodeCarResponse(from data: Data) throws -> [Car] {
        let decoder = JSONDecoder()
        return try decoder.decode([Car].self, from: data)
    }
}

extension HTTPURLResponse {
    var isSuccessfulResponse: Bool {
        return 200...299 ~= statusCode
    }
}
