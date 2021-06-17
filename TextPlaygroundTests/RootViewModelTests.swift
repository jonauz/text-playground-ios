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
        XCTAssert(rootViewModel.text == "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
        XCTAssert(!rootViewModel.text.isEmpty)
    }

    func test_whenGetRandomText_thenWordCountShouldBeTwelve() throws {
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.wordCount == 12)
    }

    func test_whenWordCountIsEqualOne_thenWordCountIsNotPlural() throws {
        publisher = getSuccessPublisher(text: "Lorem")
        let baconIpsumService = MockBaconIpsumService(getBaconIpsumReturnValue: publisher)
        rootViewModel = RootViewModel(service: baconIpsumService)
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.wordCount == 1, errorMessage(1, rootViewModel.wordCount))
        XCTAssert(!rootViewModel.wordCountLabelIsPlural, errorMessage(false, rootViewModel.wordCountLabelIsPlural))
    }

    func test_whenWordCountIsGreaterThenOne_thenWordCountIsPlural() throws {
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.wordCountLabelIsPlural)
    }

    func test_whenTextGetsZeroWords_thenWordCountIsPlural() throws {
        publisher = getSuccessPublisher(text: "")
        let baconIpsumService = MockBaconIpsumService(getBaconIpsumReturnValue: publisher)
        rootViewModel = RootViewModel(service: baconIpsumService)
        rootViewModel.getRandomText()
        rootViewModel.countWords()
        XCTAssert(rootViewModel.wordCount == 0, errorMessage(0, rootViewModel.wordCount))
        XCTAssert(rootViewModel.wordCountLabelIsPlural, errorMessage(true, rootViewModel.wordCountLabelIsPlural))
    }

    func test_whenTextGetsThreeWordsString_thenCountWordsSetsCorrectValue() throws {
        publisher = getSuccessPublisher(text: "Bacon Lorem Ipsum")
        let baconIpsumService = MockBaconIpsumService(getBaconIpsumReturnValue: publisher)
        rootViewModel = RootViewModel(service: baconIpsumService)
        rootViewModel.getRandomText()
        rootViewModel.countWords()
        XCTAssert(rootViewModel.wordCount == 3, errorMessage(3, rootViewModel.wordCount))
    }

    func test_whenServiceThrowsError_then() throws {
        publisher = getFailPublisher(error: .noAvailableData)
        let baconIpsumService = MockBaconIpsumService(getBaconIpsumReturnValue: publisher)
        rootViewModel = RootViewModel(service: baconIpsumService)
        rootViewModel.getRandomText()
        XCTAssert(rootViewModel.text.isEmpty, errorMessage(true, rootViewModel.text.isEmpty))
    }

    private func getSuccessPublisher(text: String) -> AnyPublisher<String, Error> {
        Just(text)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    private func getFailPublisher(error: DataServiceError) -> AnyPublisher<String, Error> {
        Fail(error: error)
            .eraseToAnyPublisher()
    }

    private func errorMessage(_ expected: Any, _ value: Any?) -> String {
        "expected '\(expected)', got '\(value ?? "nil")'"
    }
}
