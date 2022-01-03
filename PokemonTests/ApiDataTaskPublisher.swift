//
//  ApiDataTaskPublisher.swift
//  PokemonTests
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import Foundation

import Foundation
@testable import Pokemon

class URLSessionMock {
    let filename: String

    init(filename: String) {
        self.filename = filename
    }

    func dataTaskPublisher(for request: URL) -> URLSession.DataTaskPublisher {
        let url: URL
        if filename.isEmpty {
            // swiftlint:disable:next force_unwrapping
            url = URL(string: "https://invalidurl.com")!
        } else {
            // swiftlint:disable:next force_unwrapping
            url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: nil)!
        }
        return URLSession.shared.dataTaskPublisher(for: url)
    }
}
