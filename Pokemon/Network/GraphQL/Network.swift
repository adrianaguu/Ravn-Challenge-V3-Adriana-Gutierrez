//
//  Network.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 28/12/21.
//

import Foundation
import Apollo

final class Network {
    var apollo: NetworkClientApollo

    init(apollo: NetworkClientApollo = NetworkClient.shared) {
        self.apollo = apollo
    }
}
