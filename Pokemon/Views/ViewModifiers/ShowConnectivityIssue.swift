//
//  ShowConnectivityIssue.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 31/12/21.
//

import SwiftUI

struct ShowConnectivityIssue: ViewModifier {
    var networkError: NetworkError?

    func body(content: Content) -> some View {
        ZStack {
            Color.customSystemBackground

            if networkError == nil {
                content
            } else {
                VStack {
                    Image("Connectivity Issue")
                        .padding(.top, K.NetworkError.topPaddingErrorMessage)

                    Spacer()
                }
            }
        }
    }
}

extension View {
    func showConnectivityIssue(networkError: NetworkError?) -> some View {
        modifier(ShowConnectivityIssue(
            networkError: networkError
        ))
    }
}
