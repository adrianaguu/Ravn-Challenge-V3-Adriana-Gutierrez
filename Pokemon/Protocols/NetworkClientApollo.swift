//
//  NetworkClientApollo.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 3/01/22.
//

import Combine
import Foundation
import Apollo

protocol NetworkClientApollo {
    func fetch<Query: QueryProtocol>(query: Query) -> AnyPublisher<Query.Data, Error>
}
