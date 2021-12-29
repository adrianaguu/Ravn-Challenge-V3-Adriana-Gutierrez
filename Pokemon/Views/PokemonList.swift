//
//  PokemonList.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct PokemonList: View {
    @StateObject var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.pokemons.isEmpty {
                    ProgressView()
                        .onAppear(perform: viewModel.fetchPokemons)
                } else {
                    listOfPokemons
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pokemon List")
                        .font(.largeTitle)
                        .bold()
                        .padding(.vertical, 14)
                }
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear() {
            UINavigationBar.appearance().backgroundColor = UIColor(.cellBackground)
        }
    }

    private var listOfPokemons: some View {
        List {
            ForEach(viewModel.generations) { generation in
                VStack(alignment: .leading, spacing: .zero) {
                    Text(generation)
                        .font(.title3)

                    Divider()
                }
                .listRowSeparator(.hidden)

                ForEach(viewModel.pokemonsSectioned[generation]!) { pokemon in
                    ZStack {
                        PokemonCell(pokemon: pokemon)

                        NavigationLink(destination: PokemonDetail()) {
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
}

@available(iOS 15.0, *)
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
