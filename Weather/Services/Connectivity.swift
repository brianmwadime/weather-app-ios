//
//  Connectivity.swift
//  Weather
//
//  Created by Brian Mwakima on 1/13/23.
//

import Foundation
import Network

/// Networking Connectivity Observer
///
final class Connectivity: ObservableObject {
  let monitor: NWPathMonitor = NWPathMonitor()
  let queue: DispatchQueue = DispatchQueue(label: "Connectivity", qos: .background)

  /// Returns whether theres a network connection
  ///
  @Published var isConnected = true

  init() {
    monitor.pathUpdateHandler = { [weak self] path in
      DispatchQueue.main.async {
        self?.isConnected = path.status == .satisfied
      }
    }
  }

  /// Starts network connection monitoring
  func start() {
    monitor.start(queue: queue)
  }

  /// Stops the network connection monitoring
  func stop() {
    monitor.cancel()
  }
}
