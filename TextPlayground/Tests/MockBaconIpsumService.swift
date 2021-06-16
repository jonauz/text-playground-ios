//
//  MockBaconIpsumService.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 16/06/2021.
//

import Foundation
import Combine

struct MockBaconIpsumService: BaconIpsumServiceType {

    func getBaconIpsum() -> AnyPublisher<String, Error> {
        return Just("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
