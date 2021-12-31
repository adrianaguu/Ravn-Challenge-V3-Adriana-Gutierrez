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
    @StateObject var viewModel: PokemonDetailViewModel

    var body: some View {
        ZStack {
            viewModel.pokemon.color?.value

            VStack(spacing: .zero) {
                header
                    .padding(.bottom, 8)

                bodyDescription

                CustomDivider()

                evolutions
                    .layoutPriority(1)
            }
        }
        .onAppear {
            viewModel.fetchDetails(of: viewModel.pokemon)
        }
        .navigationTitle("Pokemon Info")
        .background(Color.cellBackground, ignoresSafeAreaEdges: .top)
    }

    private var header: some View {
        VStack {
            ResizableAsyncImage(url: viewModel.activeSprite.getFrom(pokemon: viewModel.pokemon), width: 159, height: 159)

            Picker("Active Sprite", selection: $viewModel.activeSprite) {
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

            VStack() {
                let title = "#" + String(format: "%03d", viewModel.pokemon.id) + " " + viewModel.pokemon.name
                Text(title)
                    .font(.title)

                HStack {
                    ForEach(viewModel.pokemon.types, id: \.self.name ) { type in
                        Image("Tags/\(type.name)")
                    }
                }

                Text(viewModel.pokemon.generation)
                    .font(.body)
                    .padding(.bottom, 8)

                Text(viewModel.pokemon.flavorTextEnglish ?? "")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 16)
        }
    }

    private var evolutions: some View {
        ZStack {
            Color.systemBackground

            VStack {
                Text("Evolutions")
                    .font(.title3)

                Spacer()
            }
        }
    }
}

@available(iOS 15.0, *)
struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: Pokemon.articuno))

        PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: Pokemon.bulbasaur))
    }
}
