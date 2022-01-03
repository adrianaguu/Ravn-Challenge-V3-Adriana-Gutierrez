//
//  PokemonsListService.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Combine

final class PokemonsListService {
    let decoder: JSONDecoder
    let network: Network

    init(decoder: JSONDecoder = JSONDecoder(), network: Network = .init()) {
        self.decoder = decoder
        self.network = network
    }

    func getPokemonList() -> AnyPublisher<AllPokemonQueryResponse, Error> {
        network.apollo.fetch(query: GetAllPokemonsQuery())
            .tryMap {
                return try JSONSerialization.data(
                    withJSONObject: $0.jsonObject,
                    options: []
                )
            }
            .decode(type: AllPokemonQueryResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
