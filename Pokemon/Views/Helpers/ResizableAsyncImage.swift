//
//  ResizableAsyncImage.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 29/12/21.
//

import SwiftUI
import Kingfisher

struct ResizableAsyncImage: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        KFImage(url)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .frame(width: width, height: height)
    }
}
