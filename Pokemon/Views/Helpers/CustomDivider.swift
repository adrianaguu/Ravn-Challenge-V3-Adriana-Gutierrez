//
//  CustomDivider.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 30/12/21.
//

import SwiftUI

struct CustomDivider: View {
    let color: Color = .dividerColor
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
