//
//  PokemonList.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct PokemonList: View {
    @State private var searchText = ""
    @StateObject var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            if viewModel.pokemons.isEmpty {
                ProgressView()
                    .onAppear(perform: viewModel.fetchPokemons)
            } else {
                List {
                    ForEach(viewModel.pokemons) { pokemon in
                        NavigationLink {
                            PokemonDetail()
                        } label: {
                            PokemonCell(pokemon: pokemon)
                        }
                    }

                }
                .searchable(text: $searchText)
                .navigationTitle("Pokemon List")
                .listStyle(.plain)
            }
        }
    }

    var searchResults: [Pokemon] {
        viewModel.pokemons
    }
}

@available(iOS 15.0, *)
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
