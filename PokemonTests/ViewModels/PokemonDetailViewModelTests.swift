//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import XCTest
import Combine
@testable import Pokemon
import Network

class PokemonDetailViewModelTests: XCTestCase {
    let filename = "BulbasaurDetail.json"
    var cancellable: AnyCancellable?
    let pokemon = Pokemon.bulbasaur

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        cancellable = nil
    }

    func testPokemonDescription() {
        // Given
        let viewModelSpanish = PokemonDetailViewModel(
            pokemon: pokemon,
            getEvolvesTo: { _ in return nil },
            language: "es"
        )
        let viewModelEnglish = PokemonDetailViewModel(
            pokemon: pokemon,
            getEvolvesTo: { _ in return nil },
            language: "en"
        )

        // When
        let pokemonDescriptionSpanish = viewModelSpanish.pokemonDescription
        let pokemonDescriptionEnglish = viewModelEnglish.pokemonDescription

        // Then
        XCTAssertEqual(pokemonDescriptionSpanish, pokemon.flavorTextSpanish)
        XCTAssertEqual(pokemonDescriptionEnglish, pokemon.flavorTextEnglish)
    }

    func testPokemonHasEvolutions() {
        // Given
        let viewModelNoEvolutions = PokemonDetailViewModel(
            pokemon: pokemon
        ) { _ in
            return nil
        }

        let viewModelWithEvolutions = PokemonDetailViewModel(
            pokemon: pokemon
        ) { _ in
            return [Pokemon.articuno]
        }

        // When
        let pokemonsHasEvolutions = viewModelWithEvolutions.pokemonHasEvolutions
        let pokemonHasNoEvolutions = viewModelNoEvolutions.pokemonHasEvolutions

        // Then
        XCTAssertTrue(pokemonsHasEvolutions)
        XCTAssertFalse(pokemonHasNoEvolutions)
    }

    func testFetchDetails_ShouldSuccess() {
        // Given
        let mockSession = URLSessionMock(filename: filename, shouldFail: false)
        let service = PokemonDetailService(session: mockSession)
        let viewModel = PokemonDetailViewModel(pokemon: Pokemon.bulbasaurIncomplete, service: service) { _ in
            return nil
        }

        // When
        viewModel.fetchDetails()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.2)

        // Then
        XCTAssertEqual(viewModel.pokemon, pokemon)
        XCTAssertNil(viewModel.networkError)
        XCTAssertTrue(viewModel.detailsFetchingSuccesful)
    }

    func testFetchDetails_ShouldFailWithFailedToLoadDataError() {
        // Given
        let mockSession = URLSessionMock(filename: filename, shouldFail: true)
        let service = PokemonDetailService(session: mockSession)
        let viewModel = PokemonDetailViewModel(pokemon: Pokemon.bulbasaurIncomplete, service: service) { _ in
            return nil
        }

        // When
        viewModel.fetchDetails()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.5)

        // Then
        XCTAssertEqual(viewModel.networkError, NetworkError.failedToLoadData)
        XCTAssertFalse(viewModel.detailsFetchingSuccesful)
    }

    func testFetchDetails_ShouldFailWithInvalidURL() {
        // Given
        let mockSession = URLSessionMock(filename: filename, shouldFail: true)
        let service = PokemonDetailService(session: mockSession, urlBase: "{")
        let viewModel = PokemonDetailViewModel(pokemon: Pokemon.bulbasaurIncomplete, service: service) { _ in
            return nil
        }

        // When
        viewModel.fetchDetails()
        _ = XCTWaiter.wait(for: [XCTestExpectation()], timeout: 0.4)

        // Then
        XCTAssertEqual(viewModel.networkError, NetworkError.invalidURL)
        XCTAssertFalse(viewModel.detailsFetchingSuccesful)
    }

    func testShowErrorLoadData() {
        // Given
        let viewModel = PokemonDetailViewModel(pokemon: Pokemon.bulbasaurIncomplete) { _ in
            return nil
        }

        // When
        viewModel.showErrorLoadData()

        // Then
        XCTAssertTrue(viewModel.shouldShowErrorLoadData)
    }
}
