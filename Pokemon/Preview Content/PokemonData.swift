//
//  PokemonData.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 29/12/21.
//

import Foundation

extension Pokemon {
    static var bulbasaur = Pokemon(
        id: 1,
        name: "bulbasaur",
        defaultFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
        shinyFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"),
        types: [PokemonType(name: "Grass"), PokemonType(name: "Poison")],
        generation: "Generation I"
    )
}
