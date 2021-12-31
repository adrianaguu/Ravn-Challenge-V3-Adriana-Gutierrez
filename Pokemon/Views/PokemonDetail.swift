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

                if (viewModel.pokemonHasEvolutions) {
                    CustomDivider()

                    evolutions
                        .layoutPriority(1)
                }
            }

            legendaryIcon
                .opacity(viewModel.pokemon.isLegendary ?? false ? 1 : 0)
        }
        .onAppear {
            viewModel.fetchDetails(of: viewModel.pokemon)
        }
        .navigationTitle("Pokemon Info")
        .background(Color.cellBackground, ignoresSafeAreaEdges: .top)
    }

    private var legendaryIcon: some View {
        VStack {
            HStack {
                Spacer()

                Image("Legendary icon")
                    .frame(width: 36, height: 36)
            }
            Spacer()
        }
        .padding([.top, .trailing], 16)
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
                Text(viewModel.pokemon.formatedId + " " + viewModel.pokemon.name )
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

                Spacer()
            }
            .padding(.vertical, 16)
        }
    }

    private var evolutions: some View {
        ZStack {
            Color.systemBackground
            ScrollView {
                VStack {
                    Text("Evolutions")
                        .font(.title3)


                    ForEach(viewModel.evolutions!) { evolutionPokemon in
                        evolutionCell(evolutionPokemon: evolutionPokemon)
                    }


                    Spacer()
                }
                .padding(.top, 16)
            }
        }
    }

    private func evolutionCell(evolutionPokemon: Pokemon) -> some View {
        HStack(spacing: 24) {
            Spacer()

            evolutionCellItem(pokemon: viewModel.pokemon)

            Image(systemName: "arrow.right")
                .font(.title2)
                .foregroundColor(.arrowColor)

            evolutionCellItem(pokemon: evolutionPokemon)

            Spacer()
        }
    }

    private func evolutionCellItem(pokemon: Pokemon) -> some View {
        VStack {
            ResizableAsyncImage(url: pokemon.defaultFrontalSprite, width: 64, height: 64)
                .circleBackground(color: .cellBackground)
                .frame(width: 80, height: 80)

            Group {
                Text(pokemon.name)
                    .fontWeight(.semibold)

                Text(pokemon.formatedId)
            }
            .font(.body)
        }
    }
}

@available(iOS 15.0, *)
struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        let getEvolvesTo = PokemonListViewModel().getEvolvesToOf
        PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: Pokemon.articuno, getEvolvesTo: getEvolvesTo))

        PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: Pokemon.bulbasaur, getEvolvesTo: getEvolvesTo))
    }
}
