//
//  Query.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import Apollo

protocol Query: GraphQLQuery {
    var testData: Self.Data { get }
}
