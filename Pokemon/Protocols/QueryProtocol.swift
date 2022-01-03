//
//  QueryProtocol.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 3/01/22.
//

import Foundation
import Apollo

protocol QueryProtocol: GraphQLQuery {
    var testData: Self.Data { get }
}
