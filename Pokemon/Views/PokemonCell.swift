//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct PokemonCell: View {
    let pokemon: Pokemon
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: K.PokemonCell.conerRadius)
                .foregroundColor(.cellBackground)

            HStack(spacing: .zero) {
                sprite

                VStack(alignment: .leading) {
                    Text(pokemon.name.capitalized)
                        .font(.body)
                        .fontWeight(.semibold)

                    Text("#" + String(format: "%03d", pokemon.id))
                }

                Spacer()

                ForEach(pokemon.types) { type in
                    Image("Types/\(type)")
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.leading, 24)
    }

    var sprite: some View {
        AsyncImage(url: pokemon.defaultFrontalSprite) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 72, height: 72)
        .padding(.leading, -46)
    }
}

@available(iOS 15.0, *)
struct PokemonCell_Previews: PreviewProvider {
    static let pokemonToDisplay = Pokemon (
        id: 1,
        name: "bulbasaur",
        defaultFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
        shinyFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"),
        types: ["Grass", "Poison"]
    )

    static var previews: some View {
        PokemonCell(pokemon: pokemonToDisplay)
    }
}
