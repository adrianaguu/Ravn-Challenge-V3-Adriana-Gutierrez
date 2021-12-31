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

    var body: some View {
        navigationView
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .alert(item: $viewModel.failureMessage) { failureMessage in
                Alert(
                    title: Text("There was an Error"),
                    message: Text(failureMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }

    private var navigationView: some View {
        NavigationView {
                VStack(spacing: .zero) {
                    CustomDivider()

                    if viewModel.pokemons.isEmpty {
                        Spacer()

                        ProgressView()
                            .onAppear(perform: viewModel.fetchPokemons)

                        Spacer()
                    } else {
                        listOfPokemons
                    }
                }
            .background(Color.customSystemBackground, ignoresSafeAreaEdges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(K.PokemonList.navBarTitle)
                        .font(.largeTitle)
                        .bold()
                }
            }
            .background(Color.customBackground, ignoresSafeAreaEdges: .top)
        }
        .onAppear {
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
