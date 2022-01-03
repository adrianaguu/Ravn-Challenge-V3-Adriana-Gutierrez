//
//  PokemonsListService.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Combine

final class PokemonsListService {
    let decoder: JSONDecoder
    let network: Network

    init(decoder: JSONDecoder = JSONDecoder(), network: Network = .shared) {
        self.decoder = decoder
        self.network = network
    }

    func getPokemonList() -> AnyPublisher<AllPokemonQueryResponse, Error> {
        Deferred {
            Future { [weak self] promise in
                self?.network.client.fetch(query: GetAllPokemonsQuery()) { result in
                    switch result {
                    case .success(let graphQLResult):
                        // Maping GraphQL response to custom type Pokemon
                        guard let data = graphQLResult.data,
                              let serialized = try? JSONSerialization.data(
                                withJSONObject: data.jsonObject,
                                options: []
                              ),
                              let query = try? self?.decoder.decode(
                                AllPokemonQueryResponse.self,
                                from: serialized
                              ) else {
                                  promise(.failure(NetworkError.failedToLoadData))
                                  return
                              }
                        promise(.success(query))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
