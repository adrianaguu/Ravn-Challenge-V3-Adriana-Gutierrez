//
//  CustomDivider.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import SwiftUI

struct CustomDivider: View {
    let color: Color
    let width: CGFloat

    init (color: Color = .dividerColor, width: CGFloat = 1) {
        self.color = color
        self.width = width
    }

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
