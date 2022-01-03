//
//  URLSession+Extensions.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import Foundation
import Combine

extension URLSession: NetworkServiceType {
    func execute(for url: URL) -> AnyPublisher<Data, Error> {
        self.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
}
