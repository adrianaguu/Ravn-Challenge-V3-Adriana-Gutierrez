//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Combine

final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon
    @Published var networkError: NetworkError?
    @Published var activeSprite = PokemonSprites.defaultFront
    @Published var evolutions: [Pokemon]?
    var isFetchingComplete: Bool {
        pokemon.flavorTextSpanish != nil
    }

    private var cancellable: AnyCancellable?
    private let service: PokemonDetailService
    private(set) var getEvolvesTo: (Pokemon) -> [Pokemon]?

    var pokemonHasEvolutions: Bool {
        evolutions != nil
    }

    init(pokemon: Pokemon, getEvolvesTo: @escaping (Pokemon) -> [Pokemon]?, service: PokemonDetailService = .init()) {
        self.service = service
        self.pokemon = pokemon
        self.getEvolvesTo = getEvolvesTo
        self.evolutions = getEvolvesTo(pokemon)
    }

    private func setPokemonDetails(from response: PokemonDetailsResponse) {
        pokemon.color = PokemonColor(rawValue: response.color.name)
        pokemon.isLegendary = response.isLegendary
        pokemon.flavorTextEnglish = getFlavorTextIn(language: "en")
        pokemon.flavorTextSpanish = getFlavorTextIn(language: "es")

        func getFlavorTextIn(language: String) -> String? {
            response.flavorTextEntries.first { $0.language.name == language && $0.version.name == "x" }?.flavorText
        }
    }

    func fetchDetails(of pokemon: Pokemon) {
        do {
            try cancellable = service.getPokemonDetails(id: pokemon.id)
                .receive(on: RunLoop.main)
                .sink { [weak self] result in
                    switch result {
                    case .finished:
                        self?.networkError = nil
                    case .failure:
                        self?.networkError = .failedToLoadData
                    }
                } receiveValue: { [weak self] in
                    self?.setPokemonDetails(from: $0)
                }
        } catch {
            networkError = .failedToLoadData
        }
    }
}
