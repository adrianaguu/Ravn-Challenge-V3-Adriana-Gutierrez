//
//  CustomRowStyle.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 31/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct CustomRowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.customSystemBackground)
            .listRowSeparator(.hidden)
    }
}

@available(iOS 15.0, *)
extension View {
    func customRowStyle() -> some View {
        modifier(CustomRowStyle())
    }
}
