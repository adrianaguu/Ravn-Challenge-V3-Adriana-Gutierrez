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

        var body: some View {
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink {
                            PokemonDetail()
                        } label: {
                            Text(name)
                        }
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Pokemon List")
            }
            .listStyle(.plain)
        }

        var searchResults: [String] {
            if searchText.isEmpty {
                return names
            } else {
                return names.filter { $0.contains(searchText) }
            }
        }
}

@available(iOS 15.0, *)
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
