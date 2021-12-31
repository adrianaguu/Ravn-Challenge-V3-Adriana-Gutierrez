//
//  PokemonDetailsResponse.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation

struct PokemonDetailsResponse: Codable {
    struct Language: Codable {
        let name: String
    }

    struct Version: Codable {
        let name: String
    }

    struct FlavorText: Codable {
        let flavorText: String
        let language: Language
        let version: Version
    }

    struct EvolutionChain: Codable {
        let url: URL
    }

    struct Color: Codable {
        let name: String
    }

    let color: Color
    let flavorTextEntries: [FlavorText]
    let evolutionChain: EvolutionChain
    let isLegendary: Bool
}
