//
//  DataService.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 16/06/2021.
//

import Foundation
import Combine

enum DataServiceError: Error {
    case unableToCreateURLComponents
    case unableToCreateURL
    case networkRequestFailed
    case noAvailableData
}

protocol DataServiceable {
    func fetch(withRequest request: URLRequest) -> AnyPublisher<String, Error>
}

extension DataServiceable {

    func fetch(withRequest request: URLRequest) -> AnyPublisher<String, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> String in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw DataServiceError.networkRequestFailed
                }
                let values = try JSONDecoder().decode([String].self, from: data)
                let result = values.first ?? ""
                guard values.count > 0 else {
                    throw DataServiceError.noAvailableData
                }
                return result
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
