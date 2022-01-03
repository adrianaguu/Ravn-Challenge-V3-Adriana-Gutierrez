//
//  PokemonDetailsResponse.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation

struct PokemonDetailsResponse: Codable, Equatable {
    struct Language: Codable, Equatable {
        let name: String
    }

    struct Version: Codable, Equatable {
        let name: String
    }

    struct FlavorText: Codable, Equatable {
        let flavorText: String
        let language: Language
        let version: Version
    }

    struct Color: Codable, Equatable {
        let name: String
    }

    let color: Color
    let flavorTextEntries: [FlavorText]
    let isLegendary: Bool
}
