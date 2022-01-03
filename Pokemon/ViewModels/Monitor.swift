//
//  Monitor.swift
//  Pokemon
//
//  Created by Adriana Gutierrez on 31/12/21.
//

import Network
import SwiftUI

class Monitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    private(set) var networkError: NetworkError?
    @Published var showAlert = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.showAlert = path.status != .satisfied
                self?.networkError = path.status == .satisfied ? nil : .connectivityIssue
            }
        }
        monitor.start(queue: queue)
    }
}
