//
//  PokemonColor.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import SwiftUI

enum PokemonColor: String {
    case black
    case blue
    case brown
    case gray
    case green
    case pink
    case purple
    case red
    case white
    case yellow
}

extension PokemonColor {
    var value: Color {
        switch self {
        case .black:
            return .pokemonBlack
        case .blue:
            return .pokemonBlue
        case .brown:
            return .pokemonBrown
        case .gray:
            return .pokemonGray
        case .green:
            return .pokemonGreen
        case .pink:
            return .pokemonPink
        case .purple:
            return .pokemonPurple
        case .red:
            return .pokemonRed
        case .white:
            return .pokemonWhite
        case .yellow:
            return .pokemonYellow
        }
    }
}
