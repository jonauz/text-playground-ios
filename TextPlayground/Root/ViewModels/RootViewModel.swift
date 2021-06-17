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

    @Published var wordCount: Int = 0

    var wordCountIsPlural: Bool {
        wordCount > 1
    }

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
                self.countWords()
            }
            .store(in: &cancellables)
    }

    func countWords() {
        var count = 0
        let range = text.startIndex..<text.endIndex
        text.enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized]) { _, _, _, _ in
            count += 1
        }
        wordCount = count
    }
}
