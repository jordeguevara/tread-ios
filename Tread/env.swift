//
//  env.swift
//  Tread
//
//  Created by Jorde Guevara on 3/27/25.
//

import Foundation

enum Environments {
  case development
  case staging
  case production

  // You can add more environments as needed

  /// The current active environment
  /// Change this to switch environments
  static let current: Environments = {
    #if DEBUG
      return .development
    #else
      return .production
    #endif
  }()
}

struct EnvironmentConfig {
  /// Base URL for the GraphQL endpoint
  static var baseURL: URL {
    switch Environments.current {
    case .development:
      return URL(string: "http://192.168.1.248:7777/query")!
    case .staging:
      return URL(string: "http://192.168.1.248:7777/query")!
    case .production:
      return URL(string: "https://tread-33718ec6351f.herokuapp.com/query")!
    }
  }

  /// Additional configuration values can be added here
  static var loggingEnabled: Bool {
    switch Environments.current {
    case .development, .staging:
      return true
    case .production:
      return false
    }
  }
}
