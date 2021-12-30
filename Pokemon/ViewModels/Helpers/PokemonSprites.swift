//
//  PokemonSprites.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation

enum PokemonSprites {
    case defaultFront
    case shinyFront

    func getFrom(pokemon: Pokemon) -> URL? {
        switch self {
        case .defaultFront:
            return pokemon.defaultFrontalSprite
        case .shinyFront:
            return pokemon.shinyFrontalSprite
        }
    }
}
