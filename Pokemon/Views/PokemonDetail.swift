//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI
import Kingfisher

@available(iOS 15.0, *)
struct PokemonDetail: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {
            Color.red

            VStack(spacing: .zero) {
                header
                    .padding(.bottom, 8)

                bodyDescription

                evolutions
            }
        }
        .navigationTitle("Pokemon Info")
        .background(Color.cellBackground, ignoresSafeAreaEdges: .top)
    }

    private var header: some View {
        VStack {
            ResizableAsyncImage(url: pokemon.defaultFrontalSprite, width: 159, height: 159)

            HStack(spacing: .zero) {
                Button("Default Sprite") {

                }

                Button("Shiny Sprite") {

                }
            }
        }
    }

    private var bodyDescription: some View {
        ZStack {
            Color.systemBackground
                .cornerRadius(40, corners: [.topLeft, .topRight])

            VStack {
                let title = "#" + String(format: "%03d", pokemon.id) + " " + pokemon.name
                Text(title)
                    .font(.title)

                Text(pokemon.generation)

                HStack {
                    ForEach(pokemon.types, id: \.self.name ) { type in
                        Image("Tags/\(type.name)")
                    }
                }
            }
        }
    }

    private var evolutions: some View {
        VStack {
            Color.systemBackground
        }
    }
}

@available(iOS 15.0, *)
struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: Pokemon.bulbasaur)
    }
}
