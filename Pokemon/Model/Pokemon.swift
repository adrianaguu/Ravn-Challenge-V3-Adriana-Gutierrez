//
//  Pokemon.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 27/12/21.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    var name: String
    let defaultFrontalSprite: URL?
    let shinyFrontalSprite: URL?
    let types: [PokemonType]
    let generation: String

    // Detail information
    var color: PokemonColor?
    var evolvesTo: [PokemonEvolution]?
    var flavorTextEnglish: String?
    var flavorTextSpanish: String?
    var isLegendary: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites
        case types
        case generation
        case evolvesTo = "evolves_to"
    }

    enum SpritesCodingKeys: String, CodingKey {
        case defaultFrontalSprite = "front_default"
        case shinyFrontalSprite = "front_shiny"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        name = name.capitalized
        generation = try values.decode(String.self, forKey: .generation)
        types = try values.decode([PokemonType].self, forKey: .types)
        evolvesTo = try values.decode([PokemonEvolution]?.self, forKey: .evolvesTo)


        let sprites = try values.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
        defaultFrontalSprite = try sprites.decode(URL.self, forKey: .defaultFrontalSprite)
        shinyFrontalSprite = try sprites.decode(URL.self, forKey: .shinyFrontalSprite)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(generation, forKey: .generation)
        try container.encode(types, forKey: .types)
        try container.encode(evolvesTo, forKey: .evolvesTo)

        var sprites = container.nestedContainer(keyedBy: SpritesCodingKeys.self, forKey: .sprites)
        try sprites.encode(defaultFrontalSprite, forKey: .defaultFrontalSprite)
        try sprites.encode(shinyFrontalSprite, forKey: .shinyFrontalSprite)
    }
}

extension Pokemon {
    var formattedId: String {
        "#" + String(format: "%03d", id)
    }
}
