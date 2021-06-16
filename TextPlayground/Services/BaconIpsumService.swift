//
//  BaconIpsumService.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 15/06/2021.
//

import Foundation
import Combine

protocol BaconIpsumServiceType {
    func getBaconIpsum() -> AnyPublisher<String, Error>
}

struct BaconIpsumService: BaconIpsumServiceType, DataServiceable {

    func getBaconIpsum() -> AnyPublisher<String, Error> {
        let request: URLRequest
        do {
            request = try BaconIpsumServiceEndpoint.getBaconIpsum.getURLRequest()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        return fetch(withRequest: request)
    }
}
