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
            VStack {
                if viewModel.pokemons.isEmpty {
                    ProgressView()
                        .onAppear(perform: viewModel.fetchPokemons)
                } else {
                    listOfPokemons
                }
            }
            .navigationTitle("Pokemon List")
        }
        .searchable(text: $searchText)
    }

    private var searchResults: [Pokemon] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter {
                return $0.name.starts(with: searchText.lowercased())
            }
        }
    }

    private var listOfPokemons: some View {
        List {
            ForEach(searchResults) { pokemon in
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
        .listStyle(.plain)
    }
}

@available(iOS 15.0, *)
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
