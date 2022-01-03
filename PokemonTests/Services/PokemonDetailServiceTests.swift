//
//  PokemonDetailServiceTests.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import XCTest
import Combine
@testable import Pokemon

class PokemonDetailServiceTests: XCTestCase {
    var cancellable: AnyCancellable?
    let filename = "BulbasaurDetail.json"

    var dataResponseOfBulbasaur: Data {
        let data: Data
        guard let file = Bundle(for: type(of: self)).url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from bundle:\n\(error)")
        }

        return data
    }

    var responseBulbasaur: PokemonDetailsResponse {
        do {
            let decoder = JSONDecoder.convertSnakeCaseStrategy
            return try decoder.decode(PokemonDetailsResponse.self, from: dataResponseOfBulbasaur)
        } catch {
            fatalError("Couldn't parse data to PokemonDetailsResponse")
        }
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        cancellable = nil
    }

    func testFetchPokemonDetails_ShouldSuccess() throws {
        // Given
        let mockSession = URLSessionMock(filename: filename, shouldFail: false)
        let service = PokemonDetailService(session: mockSession)
        let expectation = self.expectation(description: "Planets Service Response Expectation")


        // When
        var response: PokemonDetailsResponse?
        cancellable = try? service.getPokemonDetails(id: 1)
            .sink { result in
                switch result {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail("Test of pokemon details failed.")
                }
            } receiveValue: {
                response = $0
            }
        self.wait(for: [expectation], timeout: 0.2)

        // Then
        response = try XCTUnwrap(response)
        XCTAssertEqual(response, responseBulbasaur)
    }

    func testFetchPokemonDetails_ShouldFail() throws {
        // Given
        let mockSession = URLSessionMock(filename: filename, shouldFail: true)
        let service = PokemonDetailService(session: mockSession)
        let expectation = self.expectation(description: "Planets Service Response Expectation")


        // When
        var response: PokemonDetailsResponse?
        cancellable = try? service.getPokemonDetails(id: 1)
            .sink { result in
                switch result {
                case .finished:
                    XCTFail("Test of pokemon details succeed when it shouldn't have.")
                case .failure:
                    expectation.fulfill()
                }
            } receiveValue: {
                response = $0
            }
        self.wait(for: [expectation], timeout: 0.4)

        // Then
        XCTAssertNil(response)
    }

    func testFetchPokemonDetails_ShouldThrowInvalidURLError() throws {
        // Given
        let mockSession = URLSessionMock(filename: filename, shouldFail: true)
        let service = PokemonDetailService(session: mockSession, urlBase: "{")

        // When
        XCTAssertThrowsError(
            try service.getPokemonDetails(id: 1),
            "Get pokemon details should have thrown invalid url"
        ) { error in
            // Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
        }
    }
}
