//
//  MockGraphQLQuery.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 29/12/21.
//

import Foundation

enum MockGraphQLQuery {

    typealias JSONObject = [String: Any]

    case allPokemon

    var responseString: String {
        switch self {
        case .allPokemon:
            return MockGraphQLQuery.allPokemonResponse
        }
    }

    var responseObject: JSONObject? {

        guard
            let data = responseString.data(using: .utf8),
            let object = try? JSONSerialization.jsonObject(with: data,
                                                           options: []) as? JSONObject
            else {
                return nil
        }

        return object
    }

    private static let allPokemonResponse =
            """
            {
              "data": {
                "allPokemon": [
                  {
                    "__typename": "Pokemon"
                    "id": 1,
                    "sprites": {
                      "__typename": "Sprites"
                      "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                      "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"
                    },
                    "name": "bulbasaur",
                    "types": [
                      {
                        "__typename": "Type"
                        "name": "Grass"
                      },
                      {
                        "__typename": "Type"
                        "name": "Poison"
                      }
                    ],
                    "generation": "Generation I"
                  },
                  {
                    "__typename": "Pokemon"
                    "id": 2,
                    "sprites": {
                      "__typename": "Sprites"
                      "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png",
                      "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png"
                    },
                    "name": "ivysaur",
                    "types": [
                      {
                        "__typename": "Type"
                        "name": "Grass"
                      },
                      {
                        "__typename": "Type"
                        "name": "Poison"
                      }
                    ],
                    "generation": "Generation I"
                  }
                ]
              }
            }
            """

}
