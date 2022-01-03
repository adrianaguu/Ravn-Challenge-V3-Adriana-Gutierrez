//
//  GetAllPokemonsQuery+Extensions.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 3/01/22.
//

import Foundation

extension GetAllPokemonsQuery: QueryProtocol {
    var testData: Data {
        .init(allPokemon: [
            .init(
                id: Pokemon.bulbasaur.id,
                sprites: .init(
                    frontDefault: Pokemon.bulbasaur.defaultFrontalSprite?.absoluteString,
                    frontShiny: Pokemon.bulbasaur.shinyFrontalSprite?.absoluteString
                ),
                name: Pokemon.bulbasaur.name,
                types: [
                    .init(name: Pokemon.bulbasaur.types[0].name)
                ],
                generation: Pokemon.bulbasaur.generation,
                evolvesTo: [
                    .init(id: 2)
                ]
            ),
            .init(
                id: Pokemon.ivysaur.id,
                sprites: .init(
                    frontDefault: Pokemon.ivysaur.defaultFrontalSprite?.absoluteString,
                    frontShiny: Pokemon.ivysaur.shinyFrontalSprite?.absoluteString
                ),
                name: Pokemon.ivysaur.name,
                types: [
                    .init(name: Pokemon.ivysaur.types[0].name)
                ],
                generation: Pokemon.ivysaur.generation,
                evolvesTo: [
                    .init(id: 3)
                ]
            )
        ])
    }
}
