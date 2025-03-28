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
      id: GraphQLNullable<ID> = nil,
      numberOfReps: Int,
      restsInSeconds: GraphQLNullable<Int> = nil,
      weight: GraphQLNullable<Int> = nil
    ) {
      __data = InputDict([
        "id": id,
        "numberOfReps": numberOfReps,
        "restsInSeconds": restsInSeconds,
        "weight": weight
      ])
    }

    var id: GraphQLNullable<ID> {
      get { __data["id"] }
      set { __data["id"] = newValue }
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