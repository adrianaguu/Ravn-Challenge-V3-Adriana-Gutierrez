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
    @State private var activeSprite = PokemonSprites.defaultFront

    var body: some View {
        ZStack {
            Color.green

            VStack(spacing: .zero) {
                header
                    .padding(.bottom, 8)

                bodyDescription

                CustomDivider()

                evolutions
            }
        }
        .navigationTitle("Pokemon Info")
        .background(Color.cellBackground, ignoresSafeAreaEdges: .top)
    }

    private var header: some View {
        VStack {
            ResizableAsyncImage(url: activeSprite.getFrom(pokemon: pokemon), width: 159, height: 159)

            Picker("What is your favorite color?", selection: $activeSprite) {
                Text("Default Sprite").tag(PokemonSprites.defaultFront)
                Text("Shiny Sprite").tag(PokemonSprites.shinyFront)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
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
        ZStack {
            Color.systemBackground

            VStack {
                Text("Evolutions")
                    .font(.title3)
            }
        }
    }
}

@available(iOS 15.0, *)
struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: Pokemon.bulbasaur)
    }
}
