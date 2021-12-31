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
            return K.NetworkError.failedToLoadDataTitle
        case .connectivityIssue:
            return K.NetworkError.connectivityIssueTitle
        }
    }

    var userMessageDescription: String {
        switch self {
        case .invalidURL, .failedToLoadData:
            return K.NetworkError.failedToLoadDataDescription
        case .connectivityIssue:
            return K.NetworkError.connectivityIssueDescription
        }
    }
}
