//
//  NetworkError.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failedToLoadData
    case connectivityIssue

    var userMessageTitle: String {
        switch self {
        case .invalidURL, .failedToLoadData:
            return "There was an Error"
        case .connectivityIssue:
            return "Connectivity Issue"
        }
    }

    var userMessageDescription: String {
        switch self {
        case .invalidURL, .failedToLoadData:
            return "Failed to Load Data"
        case .connectivityIssue:
            return """
            There is a problem trying to connect.
            Please check your connectivity
            """
        }
    }
}
