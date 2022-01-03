//
//  NetworkError.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case failedToLoadData
    case connectivityIssue

    var userMessageTitle: LocalizedStringKey {
        switch self {
        case .invalidURL, .failedToLoadData:
            return K.NetworkError.failedToLoadDataTitle
        case .connectivityIssue:
            return K.NetworkError.connectivityIssueTitle
        }
    }

    var userMessageDescription: LocalizedStringKey {
        switch self {
        case .invalidURL, .failedToLoadData:
            return K.NetworkError.failedToLoadDataDescription
        case .connectivityIssue:
            return K.NetworkError.connectivityIssueDescription
        }
    }
}

extension NetworkError: Identifiable {
    var id: Self { self }
}
