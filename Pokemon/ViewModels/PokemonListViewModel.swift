//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import SwiftUI
import Combine
import os.log

final class PokemonListViewModel: ObservableObject {
    private var service: PokemonsListService
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private var cancellable: AnyCancellable?
    @Published var pokemons: [Pokemon] = [] {
        didSet {
            self.store()
        }
    }
    @Published var networkError: NetworkError?
    @Published var searchText = ""
    @Published var shouldShowErrorLoadData = false

    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter {
                return $0.name.starts(with: searchText)
            }
        }
    }

    var pokemonsSectioned: [String: [Pokemon]] {
        Dictionary(grouping: searchResults) {
            $0.generation
        }
    }

    var generations: [String] {
        pokemonsSectioned.keys.sorted(by: <).map { String($0) }
    }

    init(service: PokemonsListService = .init(), encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        self.service = service
        self.encoder = encoder
        self.decoder = decoder
    }

    func fetchPokemons() {
        shouldShowErrorLoadData = false
        do {
            try restore()
        } catch {
            cancellable = service.getPokemonList()
                .receive(on: RunLoop.main)
                .sink { [weak self] result in
                    switch result {
                    case .finished:
                        self?.networkError = nil
                    case .failure:
                        self?.networkError = .failedToLoadData
                    }
                } receiveValue: { [weak self] in
                    self?.pokemons = $0.allPokemon
                }
        }
    }

    func showErrorLoadData() {
        shouldShowErrorLoadData = true
    }

    func getEvolvesToOf(pokemon: Pokemon) -> [Pokemon]? {
        guard let evolvesTo = pokemon.evolvesTo else { return nil }
        let evolvesToIds = evolvesTo.map { $0.id }
        let result = pokemons.filter { evolvesToIds.contains($0.id) }
        return result.isEmpty ? nil : result
    }

    private func restore() throws {
        guard let url = K.PokemonsListStorage.path else { return }

        let data = try Data(contentsOf: url)
        pokemons = try decoder.decode([Pokemon].self, from: data)
    }

    private func store() {
        guard let url = K.PokemonsListStorage.path else { return }

        do {
            let data: Data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            os_log("Error: %@", log: .default, type: .error, String(describing: error))
        }
    }
}
