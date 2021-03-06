//
//  Network.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import Apollo

final class Network {
    static let shared = Network()
    private init() {}

    // swiftlint:disable:next force_unwrapping
    lazy var client = ApolloClient(url: URL(string: K.Network.pokemonsListURL)!)
}
