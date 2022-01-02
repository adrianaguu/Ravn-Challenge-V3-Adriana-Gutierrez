//
//  ConnectivityIssueAlert.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 2/01/22.
//

import SwiftUI

struct ConnectivityIssueAlert: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(NetworkError.connectivityIssue.userMessageTitle),
                    message: Text(NetworkError.connectivityIssue.userMessageDescription),
                    primaryButton: .cancel(),
                    secondaryButton: .default(
                        Text(K.tryAgain),
                        action: {}
                    )
                )
            }
    }
}

extension View {
    func connectivityIssueAlert(isPresented: Binding<Bool>) -> some View {
        modifier(ConnectivityIssueAlert(
            isPresented: isPresented
        ))
    }
}
