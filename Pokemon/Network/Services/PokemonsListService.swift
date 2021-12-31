//
//  PokemonsListService.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Combine

class PokemonsListService {
    let decoder: JSONDecoder
    let network: Network

    init(decoder: JSONDecoder = JSONDecoder(), network: Network = .shared) {
        self.decoder = decoder
        self.network = network
    }

//    func getPokemonList() -> AnyPublisher<PokemonDetailsResponse, Error> {
//        var error: PokemonsListError?
//        var dataPublisher: AnyPublisher<PokemonDetailsResponse, Error>
//        network.client.fetch(query: GetAllPokemonsQuery()) { [weak self] result in
//            dataPublisher = Just(result).eraseToAnyPublisher()
//        }
//    }
}
