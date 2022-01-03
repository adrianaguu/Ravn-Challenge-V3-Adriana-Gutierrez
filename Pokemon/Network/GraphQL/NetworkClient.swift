//
//  NetworkClient.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 3/01/22.
//

import Foundation
import Combine
import Apollo

class NetworkClient: NetworkClientApollo {
    static let shared = NetworkClient()
    // swiftlint:disable:next force_unwrapping
    private(set) lazy var client = ApolloClient(url: URL(string: K.Network.pokemonsListURL)!)

    private init() {}

    func fetch<Query: QueryProtocol>(query: Query) -> AnyPublisher<Query.Data, Error> {
        Deferred {
            Future { [weak self] promise in
                self?.client.fetch(query: query) { result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let data = graphQLResult.data else {
                                  promise(.failure(NetworkError.failedToLoadData))
                                  return
                              }
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
