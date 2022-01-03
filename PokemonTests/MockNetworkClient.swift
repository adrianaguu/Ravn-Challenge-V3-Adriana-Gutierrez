//
//  Query.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Apollo
import Combine
@testable import Pokemon

class MockNetworkClient: NetworkClientApollo {
    var shouldFail: Bool

    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }

    func fetch<Query: QueryProtocol>(query: Query) -> AnyPublisher<Query.Data, Error> {
        guard !shouldFail else {
            return Fail(outputType: Query.Data.self, failure: NetworkError.failedToLoadData)
                .eraseToAnyPublisher()
        }

        return Just(query.testData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
