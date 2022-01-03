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
    let urlBase: String

    init(
        decoder: JSONDecoder = JSONDecoder.convertSnakeCaseStrategy,
        session: NetworkServiceType = URLSession.shared,
        urlBase: String = K.Network.pokemonDetailEndPointBase
    ) {
        self.decoder = decoder
        self.session = session
        self.urlBase = urlBase
    }

    func getPokemonDetails(id: Int) throws -> AnyPublisher<PokemonDetailsResponse, Error> {
        guard let url = URL(string: urlBase + "\(id)/") else {
            throw NetworkError.invalidURL
        }

        return session.execute(for: url)
            .decode(type: PokemonDetailsResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
