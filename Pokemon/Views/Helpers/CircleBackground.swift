//
//  CircleBackgroundImage.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 31/12/21.
//

import SwiftUI

struct CircleBackground: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .fill()
                .foregroundColor(color)

            content
        }
    }
}

extension View {
    func circleBackground(color: Color) -> some View {
        modifier(CircleBackground(color: color))
    }
}
