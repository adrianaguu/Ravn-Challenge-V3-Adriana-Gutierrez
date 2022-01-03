//
//  K.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import SwiftUI

// swiftlint:disable:next type_name
enum K {
    static let pokemonList: LocalizedStringKey = "Pokemon List"
    static let pokemonInfo: LocalizedStringKey = "Pokemon Info"
    static let evolutions: LocalizedStringKey = "Evolutions"
    static let defaultSprite: LocalizedStringKey = "Default Sprite"
    static let shinySprite: LocalizedStringKey = "Shiny Sprite"
    static let tryAgain: LocalizedStringKey = "Try Again"


    enum Network {
        static let pokemonsListURL = "https://dex-server.herokuapp.com/"
        static let pokemonDetailEndPointBase = "https://pokeapli.co/api/v2/pokemon-species/"
    }

    enum NetworkError {
        static let failedToLoadDataTitle = LocalizedStringKey("There was an Error")
        static let connectivityIssueTitle = LocalizedStringKey("Connectivity Issue")
        static let failedToLoadDataDescription = LocalizedStringKey("Failed to Load Data")
        // swiftlint:disable:next line_length
        static let connectivityIssueDescription = LocalizedStringKey("There is a problem trying to connect.\nPlease check your connectivity")
        static let topPaddingErrorMessage = 16.0
        static let topPaddingErrorImage = 32.0
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

    enum PokemonDetail {
        static let headerBottomPadding = 8.0
        static let controlSegmentsPadding = 16.0
        static let legendaryIconWidth = 36.0
        static let legendaryIconHeight = 36.0
        static let legendaryIconPadding = 16.0
        static let pokemonSpriteWidth = 160.0
        static let pokemonSpriteHeight = 160.0
        static let descriptionBackgroundCornerRadius = 30.0
        static let descriptionVerticalPadding = 16.0
        static let generationTextBottomPadding = 8.0
        static let evolutionsTopPadding = 16.0
        static let evolutionCellSpacing = 24.0
        static let evolutionCellItemSpriteWidth = 64.0
        static let evolutionCellItemSpriteHeight = 64.0
        static let evolutionCellItemCircleWidth = 80.0
        static let evolutionCellItemCircleHeight = 80.0
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
