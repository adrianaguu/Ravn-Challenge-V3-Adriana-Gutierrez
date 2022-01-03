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
    @EnvironmentObject var monitor: Monitor

    var body: some View {
        ZStack {
            viewModel.pokemon.color?.value

            VStack(spacing: .zero) {
                header
                    .padding(.bottom, K.PokemonDetail.headerBottomPadding)
                    .connectivityIssueAlert(
                        isPresented: $monitor.showAlert
                    ) {
                        viewModel.fetchDetails(of: viewModel.pokemon)
                    }

                bodyDescription

                if viewModel.pokemonHasEvolutions {
                    CustomDivider()

                    evolutions
                        .layoutPriority(1)
                }

                Color.customSystemBackground
                    .ignoresSafeArea(.all, edges: .bottom)
            }

            legendaryIcon
                .opacity(viewModel.pokemon.isLegendary ?? false ? 1 : 0)
        }
        .showFailedToLoadData(
            networkError: viewModel.networkError,
            shouldShowSpinner: !viewModel.isFetchingComplete,
            shouldShowError: viewModel.shouldShowErrorLoadData
        )
        .showConnectivityIssue(
            networkError: monitor.networkError
        )
        .failedToLoadDataAlert(
            networkError: $viewModel.networkError,
            dismissAction: viewModel.showErrorLoadData
        )
        .onAppear {
            viewModel.fetchDetails(of: viewModel.pokemon)
            UISegmentedControl.appearance().backgroundColor = UIColor(Color.segmentedControlsBackground)
        }
        .navigationTitle(K.pokemonInfo)
        .background(Color.customBackground, ignoresSafeAreaEdges: .top)
    }

    private var legendaryIcon: some View {
        VStack {
            HStack {
                Spacer()

                Image("Legendary icon")
                    .frame(width: K.PokemonDetail.legendaryIconWidth, height: K.PokemonDetail.legendaryIconHeight)
            }

            Spacer()
        }
        .padding([.top, .trailing], K.PokemonDetail.legendaryIconPadding)
    }

    private var header: some View {
        VStack {
            ResizableAsyncImage(
                url: viewModel.activeSprite.getFrom(pokemon: viewModel.pokemon),
                width: K.PokemonDetail.pokemonSpriteWidth,
                height: K.PokemonDetail.pokemonSpriteHeight
            )

            Picker("Active Sprite", selection: $viewModel.activeSprite) {
                Text(K.defaultSprite).tag(PokemonSprites.defaultFront)
                Text(K.shinySprite).tag(PokemonSprites.shinyFront)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, K.PokemonDetail.controlSegmentsPadding)
        }
    }

    private var bodyDescription: some View {
        ZStack {
            Color.customSystemBackground
                .cornerRadius(K.PokemonDetail.descriptionBackgroundCornerRadius, corners: [.topLeft, .topRight])

            VStack {
                Text(viewModel.pokemon.formattedId + " " + viewModel.pokemon.name )
                    .font(.title)

                HStack {
                    ForEach(viewModel.pokemon.types, id: \.self.name ) { type in
                        Image("Tags/\(type.name)")
                    }
                }

                Text(viewModel.pokemon.generation)
                    .font(.body)
                    .padding(.bottom, K.PokemonDetail.generationTextBottomPadding)

                Text(viewModel.pokemonDescription ?? "")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(.vertical, K.PokemonDetail.descriptionVerticalPadding)
        }
    }

    private var evolutions: some View {
        ScrollView {
            VStack {
                Text(K.evolutions)
                    .font(.title3)

                ForEach(viewModel.evolutions ?? []) { evolutionPokemon in
                    evolutionCell(evolutionPokemon: evolutionPokemon)
                }

                Spacer()
            }
            .padding(.top, K.PokemonDetail.evolutionsTopPadding)
        }
        .background(Color.customSystemBackground)
    }

    private func evolutionCell(evolutionPokemon: Pokemon) -> some View {
        HStack(spacing: K.PokemonDetail.evolutionCellSpacing) {
            Spacer()

            evolutionCellItem(pokemon: viewModel.pokemon)

            Image(systemName: "arrow.right")
                .font(.title2)
                .foregroundColor(.arrowColor)

            NavigationLink {
                PokemonDetail(
                    viewModel:
                        PokemonDetailViewModel(
                            pokemon: evolutionPokemon,
                            getEvolvesTo: viewModel.getEvolvesTo
                        )
                )
            } label: {
                evolutionCellItem(pokemon: evolutionPokemon)
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()
        }
    }

    private func evolutionCellItem(pokemon: Pokemon) -> some View {
        VStack {
            ResizableAsyncImage(
                url: pokemon.defaultFrontalSprite,
                width: K.PokemonDetail.evolutionCellItemSpriteWidth,
                height: K.PokemonDetail.evolutionCellItemSpriteHeight
            )
                .circleBackground(color: .customBackground)
                .frame(
                    width: K.PokemonDetail.evolutionCellItemCircleWidth,
                    height: K.PokemonDetail.evolutionCellItemCircleHeight
                )

            Group {
                Text(pokemon.name)
                    .fontWeight(.semibold)

                Text(pokemon.formattedId)
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
