//
//  RootViewModel.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 15/06/2021.
//

import Foundation
import Combine

class RootViewModel: ObservableObject {

    let service: BaconIpsumServiceType

    private var cancellables = Set<AnyCancellable>()

    @Published var text: String = ""

    init(service: BaconIpsumServiceType) {
        self.service = service
    }

    func getRandomText() {
        service.getBaconIpsum()
            .sink { completion in
                switch completion {
                case .finished:
                    print("successfully fetched data")
                case .failure(let error):
                    print("failure - \(error)")
                }
            } receiveValue: { result in
                print("result: \(result)")
                self.text = result

            }
            .store(in: &cancellables)
    }
}
