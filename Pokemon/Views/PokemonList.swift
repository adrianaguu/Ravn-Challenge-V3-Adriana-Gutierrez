//
//  PokemonList.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct PokemonList: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: PokemonListViewModel
    @EnvironmentObject var monitor: Monitor

    var body: some View {
        navigationView
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
    }

    private var navigationView: some View {
        NavigationView {
            VStack(spacing: .zero) {
                CustomDivider()
                    .failedToLoadDataAlert(
                        networkError: $viewModel.networkError,
                        dismissAction: viewModel.showErrorLoadData
                    )

                listOfPokemons
                    .showFailedToLoadData(
                        networkError: viewModel.networkError,
                        shouldShowSpinner: viewModel.pokemons.isEmpty,
                        shouldShowError: viewModel.shouldShowErrorLoadData
                    )
                    .showConnectivityIssue(
                        networkError: monitor.networkError
                    )
                    .connectivityIssueAlert(isPresented: $monitor.showAlert)
            }
            .background(Color.customSystemBackground, ignoresSafeAreaEdges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(K.pokemonList)
                        .font(.largeTitle)
                        .bold()
                }
            }
            .background(Color.customBackground, ignoresSafeAreaEdges: .top)
        }
        .onAppear {
            viewModel.fetchPokemons()
            UINavigationBar.appearance().backgroundColor = UIColor(.customBackground)
        }
    }

    private var listOfPokemons: some View {
        List {
            ForEach(viewModel.generations) { generation in
                sectionHeader(title: generation)

                ForEach(viewModel.pokemonsSectioned[generation] ?? []) { pokemon in
                    ZStack {
                        PokemonCell(pokemon: pokemon)

                        NavigationLink {
                            PokemonDetail(
                                viewModel: PokemonDetailViewModel(
                                    pokemon: pokemon,
                                    getEvolvesTo: viewModel.getEvolvesToOf
                                )
                            )
                        } label: {
                            EmptyView()
                        }
                        .opacity(.zero)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .customRowStyle()
                }
            }
        }
        .listStyle(.plain)
    }

    private func sectionHeader(title: String) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .font(.title3)
                .padding(.top, K.PokemonList.sectionHeaderPadding)

            CustomDivider(color: colorScheme == .dark ? .white : .dividerColor)
        }
        .customRowStyle()
    }
}

@available(iOS 15.0, *)
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(viewModel: .init())
    }
}
