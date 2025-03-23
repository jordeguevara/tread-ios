// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension Tread {
  struct ExerciseInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      id: ID,
      name: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "id": id,
        "name": name
      ])
    }

    var id: ID {
      get { __data["id"] }
      set { __data["id"] = newValue }
    }

    var name: GraphQLNullable<String> {
      get { __data["name"] }
      set { __data["name"] = newValue }
    }
  }

}