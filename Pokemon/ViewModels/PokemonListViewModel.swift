//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import SwiftUI

enum Pokemons: Error {
    case idIsRequired
}

final class PokemonListViewModel: ObservableObject {
    private var service = PokemonsListService.shared
    @Published var pokemons: [Pokemon] = []
    @Published var failureMessage: String?
    @Published var searchText = ""

    var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter {
                return $0.name.starts(with: searchText.lowercased())
            }
        }
    }

    var pokemonsSectioned: [String: [Pokemon]] {
        Dictionary(grouping: searchResults, by: { $0.generation })
    }

    var generations: [String] {
        pokemonsSectioned.keys.sorted(by: <).map { String($0) }
    }

    func fetchPokemons() {
        service.client.fetch(query: GetAllPokemonsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else { return }
                self?.failureMessage = nil
                let json = data.jsonObject
                let serialized = try! JSONSerialization.data(withJSONObject: json, options: [])
                let query = try! JSONDecoder().decode(Query.self, from: serialized)
                DispatchQueue.main.async {
                    self?.pokemons = query.allPokemon
                }
            case .failure(let error):
                self?.failureMessage = error.localizedDescription
            }
        }
    }
}
