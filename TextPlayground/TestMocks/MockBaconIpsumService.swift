//
//  MockBaconIpsumService.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 16/06/2021.
//

import Foundation
import Combine

struct MockBaconIpsumService: BaconIpsumServiceType {

    var getBaconIpsumReturnValue: AnyPublisher<String, Error>

    init(
        getBaconIpsumReturnValue: AnyPublisher<String, Error> = Just("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    ) {
        self.getBaconIpsumReturnValue = getBaconIpsumReturnValue
    }

    func getBaconIpsum() -> AnyPublisher<String, Error> {
        return getBaconIpsumReturnValue
    }
}
