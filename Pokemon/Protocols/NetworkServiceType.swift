//
//  NetworkServiceType.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import Combine
import Foundation

protocol NetworkServiceType {
    func execute(for url: URL) -> AnyPublisher<Data, Error>
}
