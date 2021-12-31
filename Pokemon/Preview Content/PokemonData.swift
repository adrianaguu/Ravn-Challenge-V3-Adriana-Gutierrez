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
        name: "Bulbasaur",
        defaultFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
        shinyFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"),
        types: [PokemonType(name: "Grass"), PokemonType(name: "Poison")],
        generation: "Generation I",
        color: .green,
        flavorTextEnglish: "A strange seed was planted on its back at birth.\nThe plant sprouts and grows with this Pokémon.",
        flavorTextSpanish: "Una rara semilla le fue plantada en el lomo al nacer.\nLa planta brota y crece con este Pokémon.",
        isLegendary: false
    )

    static var articuno = Pokemon(
        id: 144,
        name: "Articuno",
        defaultFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/144.png"),
        shinyFrontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/144.png"),
        types: [PokemonType(name: "Ice"), PokemonType(name: "Flying")],
        generation: "Generation I",
        color: .blue,
        flavorTextEnglish: "A legendary bird Pokémon. It can create blizzards\nby freezing moisture in the air.",
        flavorTextSpanish: "Legendario Pokémon pájaro capaz de generar\nventiscas congelando la humedad del aire.",
        isLegendary: true
    )
}
