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
    @Published var failureMessage: String?
    @Published var activeSprite = PokemonSprites.defaultFront

    private var cancellable: AnyCancellable?
    private let service: PokemonDetailService

    init(pokemon: Pokemon, service: PokemonDetailService = .init()) {
        self.service = service
        self.pokemon = pokemon
    }

    private func setPokemonDetails(from response: PokemonDetailsResponse) {
        pokemon.color = PokemonColor(rawValue: response.color.name)
    }

    func fetchDetails(of pokemon: Pokemon) {
        do {
            try cancellable = service.getPokemonDetails(id: pokemon.id)
                .receive(on: RunLoop.main)
                .sink { [weak self] result in
                    switch result {
                    case .finished:
                        self?.failureMessage = nil
                    case .failure(let error):
                        self?.failureMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] in
                    self?.setPokemonDetails(from: $0)
                }
        } catch {
            failureMessage = NetworkError.failedToLoadData.userMessageDescription
        } 
    }
}
