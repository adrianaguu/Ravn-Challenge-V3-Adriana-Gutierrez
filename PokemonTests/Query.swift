//
//  Query.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation

protocol Query: GraphQLQuery {
    var testData: Self.Data { get }
}
