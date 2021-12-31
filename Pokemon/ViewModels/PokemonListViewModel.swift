//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import SwiftUI
import os.log

final class PokemonListViewModel: ObservableObject {
    private var service: Network
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    @Published var pokemons: [Pokemon] = [] {
        didSet {
            self.store()
        }
    }
    @Published var failureMessage: String?
    @Published var searchText = ""

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
        Dictionary(grouping: searchResults, by: { $0.generation })
    }

    var generations: [String] {
        pokemonsSectioned.keys.sorted(by: <).map { String($0) }
    }

    init(service: Network = Network.shared, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) {
        self.service = service
        self.encoder = encoder
        self.decoder = decoder
    }

    func fetchPokemons() {
        do {
            try restore()
        } catch {
            service.client.fetch(query: GetAllPokemonsQuery()) { [weak self] result in
                switch result {
                case .success(let graphQLResult):
                    // Maping GraphQL response to custom type Pokemon
                    guard let data = graphQLResult.data,
                          let serialized = try? JSONSerialization.data(withJSONObject: data.jsonObject, options: []),
                          let query = try? self?.decoder.decode(AllPokemonQueryResponse.self, from: serialized) else {
                              self?.failureMessage = "Data couldn't be loaded correctly."
                              return
                          }

                    self?.failureMessage = nil
                    DispatchQueue.main.async {
                        self?.pokemons = query.allPokemon
                    }
                case .failure(let error):
                    self?.failureMessage = error.localizedDescription
                }
            }
        }
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
