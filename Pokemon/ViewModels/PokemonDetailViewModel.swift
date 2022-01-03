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
    @Published var shouldShowErrorLoadData = false
    @Published var evolutions: [Pokemon]?

    private var language: String?

    private var cancellable: AnyCancellable?
    private let service: PokemonDetailService
    private(set) var getEvolvesTo: (Pokemon) -> [Pokemon]?

    var pokemonHasEvolutions: Bool {
        evolutions != nil
    }

    var detailsFetchingSuccesful: Bool {
        pokemon.flavorTextSpanish != nil
    }

    var pokemonDescription: String? {
        language == "en" ? pokemon.flavorTextEnglish : pokemon.flavorTextSpanish
    }

    init(
        pokemon: Pokemon,
        service: PokemonDetailService = .init(),
        getEvolvesTo: @escaping (Pokemon) -> [Pokemon]?,
        language: String? = Locale.current.languageCode
    ) {
        self.service = service
        self.pokemon = pokemon
        self.getEvolvesTo = getEvolvesTo
        self.evolutions = getEvolvesTo(pokemon)
        self.language = language
    }

    private func setPokemonDetails(from response: PokemonDetailsResponse) {
        pokemon.color = PokemonColor(rawValue: response.color.name)
        pokemon.isLegendary = response.isLegendary

        pokemon.flavorTextEnglish = getFlavorTextIn(language: "en")
        pokemon.flavorTextSpanish = getFlavorTextIn(language: "es")

        func getFlavorTextIn(language: String) -> String? {
            response.flavorTextEntries.first {
                $0.language.name == language && $0.version.name == K.PokemonDetail.version
            }?.flavorText
        }
    }

    func showErrorLoadData() {
        shouldShowErrorLoadData = true
    }

    func fetchDetails() {
        shouldShowErrorLoadData = false
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
            networkError = .invalidURL
        }
    }
}
