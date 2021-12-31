//
//  K.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation

// swiftlint:disable:next type_name
enum K {
    enum Network {
        static let pokemonsListURL = "https://dex-server.herokuapp.com/"
        static let pokemonDetailEndPointBase = "https://pokeapi.co/api/v2/pokemon-species/"
    }

    enum NetworkError {
        static let failedToLoadDataTitle = "There was an Error"
        static let connectivityIssueTitle = "Connectivity Issue"
        static let failedToLoadDataDescription = "Failed to Load Data"
        static let connectivityIssueDescription = "There is a problem trying to connect\nPlease check your connectivity"
    }

    enum PokemonCell {
        static let rectangleConerRadius = 17.0
        static let horizontalPaddingRectangle = 16.0
        static let leadingPadding = 24.0
        static let spriteWidth = 72.0
        static let spriteHeight = 72.0
        static let spriteSetOffX = -46.0
        static let spaceBetweenSpriteAndText = 8.0
    }

    enum PokemonList {
        static let sectionHeaderPadding = 16.0
    }

    enum PokemonsListStorage {
        static let fileName = "pokemons"
        static var path: URL? {
            let cachesDirectory = FileManager.default.urls(
                for: .cachesDirectory,
                   in: .userDomainMask
            )
                .first
            return cachesDirectory?.appendingPathComponent(fileName)
        }
    }
}
