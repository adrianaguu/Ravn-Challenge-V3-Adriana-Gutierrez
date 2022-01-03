//
//  PokemonsListServiceTests.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 3/01/22.
//

import XCTest
import Combine
@testable import Pokemon

class PokemonsListServiceTests: XCTestCase {
    var cancellable: AnyCancellable?

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        cancellable = nil
    }

    func testFetchPokemonDetails_ShouldSuccess() throws {
        // Given
        let mockNetworkClient = MockNetworkClient(shouldFail: false)
        let network = Network(apollo: mockNetworkClient)
        let service = PokemonsListService(network: network)
        let expectation = self.expectation(description: "Service Response Expectation")


        // When
        var response: AllPokemonQueryResponse?
        cancellable = service.getPokemonList()
            .sink { result in
                switch result {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail("Test of fetch pokemon list failed.")
                }
            } receiveValue: {
                response = $0
            }
        self.wait(for: [expectation], timeout: 0.2)

        // Then
        response = try XCTUnwrap(response)
        XCTAssertEqual(response?.allPokemon.count, 2)
    }

    func testFetchPokemonDetails_ShouldFail() throws {
        // Given
        let mockNetworkClient = MockNetworkClient(shouldFail: true)
        let network = Network(apollo: mockNetworkClient)
        let service = PokemonsListService(network: network)
        let expectation = self.expectation(description: "Service Response Expectation")


        // When
        var response: AllPokemonQueryResponse?
        cancellable = service.getPokemonList()
            .sink { result in
                switch result {
                case .finished:
                    XCTFail("Test of get pokemon list succeed when it shouldn't have.")
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
}
