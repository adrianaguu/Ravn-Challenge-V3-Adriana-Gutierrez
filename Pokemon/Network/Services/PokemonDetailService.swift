//
//  PokemonDetailService.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Combine

struct PokemonDetailService {
    let decoder: JSONDecoder
    let session: NetworkServiceType

    init(decoder: JSONDecoder = JSONDecoder.convertSnakeCaseStrategy, session: NetworkServiceType = URLSession.shared) {
        self.decoder = decoder
        self.session = session
    }

    func getPokemonDetails(id: Int) throws -> AnyPublisher<PokemonDetailsResponse, Error> {
        guard let url = URL(string: K.Network.pokemonDetailEndPointBase + "\(id)/") else {
            throw NetworkError.invalidURL
        }

        return session.execute(for: url)
            .decode(type: PokemonDetailsResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
