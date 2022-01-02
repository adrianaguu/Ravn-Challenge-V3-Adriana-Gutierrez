//
//  ShowFailedToLoadData.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import SwiftUI

struct ShowFailedToLoadData: ViewModifier {
    @Binding var networkError: NetworkError?
    @Binding var shouldShowError: Bool
    let shouldShowSpinner: Bool

    func body(content: Content) -> some View {
        ZStack {
            Color.customSystemBackground

            if networkError == nil {
                if shouldShowError {
                    VStack {
                        Text("Failed to Load Data")
                            .foregroundColor(.red)
                            .padding(.top, 16)

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
    func showFailedToLoadData(networkError: Binding<NetworkError?>, shouldShowSpinner: Bool, shouldShowError: Binding<Bool>) -> some View {
        modifier(ShowFailedToLoadData(
            networkError: networkError,
            shouldShowError: shouldShowError,
            shouldShowSpinner: shouldShowSpinner
        ))
    }
}
