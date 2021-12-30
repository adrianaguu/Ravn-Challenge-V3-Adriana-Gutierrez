//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI
import Kingfisher

@available(iOS 15.0, *)
struct PokemonCell: View {
    let pokemon: Pokemon
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: K.PokemonCell.rectangleConerRadius)
                .foregroundColor(.cellBackground)

            HStack(spacing: .zero) {
                sprite

                nameAndId

                Spacer()

                types
            }
            .padding(.horizontal, K.PokemonCell.horizontalPaddingRectangle)
        }
        .padding(.leading, K.PokemonCell.leadingPadding)
    }

    private var nameAndId: some View {
        VStack(alignment: .leading) {
            Text(pokemon.name)
                .font(.body)
                .fontWeight(.semibold)

            Text("#" + String(format: "%03d", pokemon.id))
        }
        .padding(.leading, K.PokemonCell.spaceBetweenSpriteAndText)
    }

    private var sprite: some View {
        ResizableAsyncImage(
            url: pokemon.defaultFrontalSprite,
            width: K.PokemonCell.spriteWidth,
            height: K.PokemonCell.spriteHeight
        )
        .padding(.leading, K.PokemonCell.spriteSetOffX)
    }

    private var types: some View {
        ForEach(pokemon.types, id: \.self.name ) { type in
            Image("Types/\(type.name)")
        }
    }
}

@available(iOS 15.0, *)
struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: Pokemon.bulbasaur)
    }
}
