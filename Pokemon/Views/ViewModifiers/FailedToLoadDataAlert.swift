//
//  FailedToLoadDataAlert.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import SwiftUI

struct FailedToLoadDataAlert: ViewModifier {
    @Binding var networkError: NetworkError?
    let dismissAction: () -> Void

    func body(content: Content) -> some View {
        content
            .alert(item: $networkError) { error in
                Alert(
                    title: Text(error.userMessageTitle),
                    message: Text(error.userMessageDescription),
                    dismissButton: .default(Text("Ok"), action: dismissAction)
                )
            }
    }
}

extension View {
    func failedToLoadDataAlert(networkError: Binding<NetworkError?>, dismissAction: @escaping () -> Void) -> some View {
        modifier(FailedToLoadDataAlert(
            networkError: networkError,
            dismissAction: dismissAction
        ))
    }
}
