//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct PokemonApp: App {
    @StateObject var pokemonListViewModel = PokemonListViewModel()
    @StateObject var monitor = Monitor()
    var body: some Scene {
        WindowGroup {
            PokemonList(viewModel: pokemonListViewModel)
                .environmentObject(monitor)
        }
    }
}
