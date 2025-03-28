//
//  Client.swift
//  Tread
//
//  Created by Jorde Guevara on 2/10/25.
//

import Apollo
import Foundation

//let apolloClient = ApolloClient(url: URL(string: "http://192.168.1.248:7777/query")!)

let apolloClient: ApolloClient = {
  // Get the device ID
  let deviceID = DeviceIDManager.getDeviceID()

  // Create a network transport with the device ID in the header
  let cache = InMemoryNormalizedCache()
  let store = ApolloStore(cache: cache)

  let provider = DefaultInterceptorProvider(store: store)

  print("🚀 Environment: \(Environments.current)")
  print("🔗 API URL: \(EnvironmentConfig.baseURL)")

  let transport = RequestChainNetworkTransport(
    interceptorProvider: provider,
    endpointURL: EnvironmentConfig.baseURL,
    additionalHeaders: ["X-Device-ID": deviceID]
  )

  return ApolloClient(networkTransport: transport, store: store)
}()
