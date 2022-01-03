//
//  ShowFailedToLoadData.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import SwiftUI

struct ShowFailedToLoadData: ViewModifier {
    var networkError: NetworkError?
    var shouldShowError: Bool
    let shouldShowSpinner: Bool

    func body(content: Content) -> some View {
        ZStack {
            Color.customSystemBackground
                .ignoresSafeArea(.all, edges: .bottom)

            if networkError == nil {
                if shouldShowError {
                    VStack {
                        Text(K.NetworkError.failedToLoadDataDescription)
                            .foregroundColor(.red)
                            .padding(.top, K.NetworkError.topPaddingErrorMessage)

                        Spacer()
                    }
                } else if shouldShowSpinner {
                    ProgressView()
                } else {
                    content
                }
            }
        }
    }
}

extension View {
    func showFailedToLoadData(networkError: NetworkError?, shouldShowSpinner: Bool, shouldShowError: Bool) -> some View {
        modifier(ShowFailedToLoadData(
            networkError: networkError,
            shouldShowError: shouldShowError,
            shouldShowSpinner: shouldShowSpinner
        ))
    }
}
