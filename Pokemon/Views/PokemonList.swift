//
//  PokemonList.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct PokemonList: View {
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
            ZStack {
                Color.systemBackground

                VStack(spacing: .zero) {
                    CustomDivider()

                    if viewModel.pokemons.isEmpty {
                        ProgressView()
                            .onAppear(perform: viewModel.fetchPokemons)
                    } else {
                        listOfPokemons
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pokemon List")
                        .font(.largeTitle)
                        .bold()
                }
            }
            .background(Color.cellBackground, ignoresSafeAreaEdges: .top)
        }
        .onAppear() {
            UINavigationBar.appearance().backgroundColor = UIColor(.cellBackground)
        }
    }

    private var listOfPokemons: some View {
        List {
            ForEach(viewModel.generations) { generation in
                sectionHeader(title: generation)

                ForEach(viewModel.pokemonsSectioned[generation]!) { pokemon in
                    ZStack {
                        PokemonCell(pokemon: pokemon)

                        NavigationLink(destination: PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: pokemon, getEvolvesTo: viewModel.getEvolvesToOf))) {
                            EmptyView()
                        }
                        .opacity(.zero)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .listRowSeparator(.hidden)
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

            CustomDivider()
        }
        .listRowSeparator(.hidden)
    }
}

@available(iOS 15.0, *)
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList(viewModel: .init())
    }
}
