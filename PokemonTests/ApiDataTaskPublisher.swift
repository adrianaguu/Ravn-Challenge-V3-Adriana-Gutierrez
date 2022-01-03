//
//  ApiDataTaskPublisher.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import Foundation
import Combine
@testable import Pokemon

class URLSessionMock: NetworkServiceType {
    let filename: String
    let shouldFail: Bool

    init(filename: String, shouldFail: Bool) {
        self.filename = filename
        self.shouldFail = shouldFail
    }

    func execute(for url: URL) -> AnyPublisher<Data, Error> {
        let url: URL
        if shouldFail {
            // swiftlint:disable:next force_unwrapping
            url = URL(string: "https://invalidurl.com")!
        } else {
            // swiftlint:disable:next force_unwrapping
            url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: nil)!
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
}
