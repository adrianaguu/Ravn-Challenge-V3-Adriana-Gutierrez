//
//  PokemonsListService.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import Apollo

struct PokemonsListService {
    static let shared = PokemonsListService()
    private init() {}

    lazy var client = ApolloClient(url: URL(string: K.Network.allPokemonsEndPoint)!)
}
