//
//  RootViewModelTests.swift
//  TextPlaygroundTests
//
//  Created by Jonas Simkus on 15/06/2021.
//

import XCTest
@testable import TextPlayground
import Combine

class RootViewModelTests: XCTestCase {

    var rootViewModel: RootViewModel!
    var publisher: AnyPublisher<String, Error>!

    override func setUpWithError() throws {
        rootViewModel = RootViewModel(service: MockBaconIpsumService())
    }

    override func tearDownWithError() throws {
        rootViewModel = nil
    }

    func test_whenInit_thenTextIsEmpty() throws {
        XCTAssert(rootViewModel.text.isEmpty)
    }

    func test_whenInit_thenWordCountShouldBeZero() throws {
        XCTAssert(rootViewModel.wordCount == 0)
    }

    func test_whenGetRandomText_thenTextHasValue() throws {
        rootViewModel.getRandomText()
        XCTAssert(!rootViewModel.text.isEmpty)
    }

    func test_whenGetRandomText_thenWordCountShouldBeTwelve() throws {
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.wordCount == 12)
    }

    func test_whenWordCountIsEqualOne_thenWordCountIsNotPlural() throws {
        XCTAssert(!rootViewModel.wordCountIsPlural)
    }

    func test_whenWordCountIsGreaterThenOne_thenWordCountIsPlural() throws {
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.wordCountIsPlural)
    }

    func test_whenTextGetsThreeWordsString_thenCountWordsSetsCorrectValue() throws {
        publisher = Just("Bacon Lorem Ipsum")
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let baconIpsumService = MockBaconIpsumService(getBaconIpsumReturnValue: publisher)
        rootViewModel = RootViewModel(service: baconIpsumService)
        rootViewModel.getRandomText()
        rootViewModel.countWords()
        XCTAssert(rootViewModel.wordCount == 3, "returned '\(rootViewModel.wordCount)'")
    }

    func test_whenServiceThrowsError_then() throws {
        publisher = Fail(error: DataServiceError.noAvailableData)
            .eraseToAnyPublisher()
        let baconIpsumService = MockBaconIpsumService(getBaconIpsumReturnValue: publisher)
        rootViewModel = RootViewModel(service: baconIpsumService)
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.text.isEmpty, "returned '\(rootViewModel.text)'")
    }
}
