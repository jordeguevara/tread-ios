// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension Tread {
  struct SetInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      numberOfReps: Int,
      restsInSeconds: GraphQLNullable<Int> = nil,
      weight: GraphQLNullable<Int> = nil
    ) {
      __data = InputDict([
        "numberOfReps": numberOfReps,
        "restsInSeconds": restsInSeconds,
        "weight": weight
      ])
    }

    var numberOfReps: Int {
      get { __data["numberOfReps"] }
      set { __data["numberOfReps"] = newValue }
    }

    var restsInSeconds: GraphQLNullable<Int> {
      get { __data["restsInSeconds"] }
      set { __data["restsInSeconds"] = newValue }
    }

    var weight: GraphQLNullable<Int> {
      get { __data["weight"] }
      set { __data["weight"] = newValue }
    }
  }

}