//
//  UINavigationController+Extensions.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 29/12/21.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
